"""
importing the necessary libraries
"""
import numpy as np
import mediapipe as mp
import cv2

import math
from scipy.signal import find_peaks
from scipy.signal import savgol_filter
import time

from ball_tracker import BallTracker
from utils import calculer_vitesse_metres_par_seconde

mp_drawing = mp.solutions.drawing_utils
mp_pose = mp.solutions.pose
pose = mp_pose.Pose(min_detection_confidence=0.5, min_tracking_confidence=0.5)




def ball_finder_yolov8(frame,model):
    """
    impute:frame & yolo_v8 model for detection
    output:detect and mask the ball area
    """
    # Convert BGR image to RGB

    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    # Run inference on the model
    outputs = model(frame)

    # Extract the bounding boxes and class probabilities for detected objects
    xyxys = []
    confidences = []
    class_ids = []
    xyxy = []
    ball_boxes=[]
    x1 = 0
    x2 = 0
    y1 = 0
    y2 = 0
    # Extract detections for person class
    for result in outputs:
        boxes = result.boxes.cpu().numpy()
        class_id = boxes.cls
        conf = boxes.conf
        xyxy = boxes.xyxy

        if any(class_id) == 0.0:
            xyxys.append(result.boxes.xyxy.cpu().numpy())
            confidences.append(result.boxes.conf.cpu().numpy())
            class_ids.append(result.boxes.cls.cpu().numpy().astype(int))


    #print("boxes:",xyxy)
    for box, id in zip(xyxy, class_id):
        if id == 32:  # class 0 corresponds to ball (modify this if necessary)
            ball_boxes.append(box)

    #print("ball_box",ball_boxes)


    # for box, score in zip(boxes, preds[:, 0]):
    #     if score > 0.5 and box[5] == 32:  # class 0 corresponds to ball
    #         ball_boxes.append(box)
# Create a binary mask for the ball objects
    mask = np.zeros(frame.shape[:2], dtype=np.uint8)
    mask = mask.reshape(frame.shape[:2])
    for box in ball_boxes:
        x1, y1, x2, y2 = box[:4]
        mask[int(y1):int(y2), int(x1):int(x2)] = 255
    ball_box = [x1, x2, y1, y2]
    mask[int(y1):int(y2), int(x1):int(x2)] = 255
    return mask, ball_box
# def estimate_ground_threshold(frame):
#     # Diviser l'image en plusieurs régions verticales
#     num_regions = 10
#     region_height = frame.shape[0] // num_regions
#
#     # Calculer la valeur minimale de la coordonnée y dans chaque région
#     min_y_values = []
#     for i in range(num_regions):         region = frame[i*region_height : (i+1)*region_height, :]
#         min_y = np.min(region[:, :, 0])  # Utiliser le canal bleu pour estimer la hauteur du sol
#         min_y_values.append(min_y)
#
#     # Estimation globale de la hauteur du sol
#     ground_threshold = int(np.mean(min_y_values))  # Utiliser la moyenne des valeurs minimales
#
#     return ground_threshold
def peak_calculator(height, cur_num_peaks):
    """
       impute:the height and the number of peak president
       output:the current juggling number to display
       """
    if len(height) > 9 :
        # invert and filter input
        y = savgol_filter(height, 9, 2)
        # use peak finder
        peaks, _ = find_peaks(y)
        if len(peaks) < cur_num_peaks:
            peaks = [cur_num_peaks]
    else:
        peaks = [0]
    return str(len(peaks))



def jonglage(model, cap):
    """
    Perform ball detection and juggling analysis on real-time camera input.
    """
    x_centers = []
    y_centers = []
    ball_boxes=[]
    vitesse_metres_par_seconde=0
    backSub = cv2.createBackgroundSubtractorKNN()
    background_subtract = True
# Use the default camera (change the index if you have multiple cameras)
    ball_tracker = BallTracker(fps=0)

    # Check if camera opened successfully
    if not cap.isOpened():
        print("Error opening camera")
        return

    peaks = 0

    while True:
        # Capture frame-by-frame
        start_time = time()
        ret, frame = cap.read()

        if not ret:
            print("Error reading camera frame")
            break

        try:
            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            pose_results = pose.process(frame_rgb)
            results = pose.process(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB))
            #mp_drawing.draw_landmarks(frame, pose_results.pose_landmarks, mp_pose.POSE_CONNECTIONS)
            # Récupérer les dimensions de l'image
            height, width, channels = frame.shape

            ball_radius = 0
            dist_hand_ball = 0
            cY = 0
            dic = {}

            # Check if any landmarks are found.
            if results.pose_landmarks:
                # Iterate two times as we only want to display first two landmarks.
                for i in range(len(mp_pose.PoseLandmark)):
                    # Get the name of the landmark
                    landmark_name = mp_pose.PoseLandmark(i).name
                    # Get the position of the landmark
                    landmark_position = results.pose_landmarks.landmark[mp_pose.PoseLandmark(i).value]
                    # Add the landmark position to the dictionary
                    dic[landmark_name] = (landmark_position.x, landmark_position.y, landmark_position.z)
                    # Check if the landmark is the foot landmark.
                    if (
                            landmark_name == 'LEFT_FOOT_INDEX' or landmark_name == 'RIGHT_FOOT_INDEX' or
                            landmark_name == 'RIGHT_KNEE' or landmark_name == 'LEFT_KNEE' or
                            landmark_name == 'LEFT_SHOULDER' or landmark_name == 'RIGHT_SHOULDER' or
                            landmark_name == 'LEFT_THUMB' or landmark_name == 'RIGHT_THUMB' or
                            landmark_name == 'LEFT_PINKY' or landmark_name == 'RIGHT_PINKY' or
                            landmark_name == 'LEFT_WRIST' or landmark_name == 'RIGHT_WRIST'
                    ):
                        # Convert the normalized position to pixel coordinates.
                        x_px, y_px = int(landmark_position.x * width), int(landmark_position.y * height)
                        # Draw a rectangle around the foot landmark.
                        cv2.rectangle(frame, (x_px - 5, y_px - 5), (x_px + 5, y_px + 5), (0, 255, 0), 2)

            # if background subtraction
            if background_subtract:
                # background subtract
                fgMask = backSub.apply(frame)
                # bitwise multiplication to grab moving part
                new_frame = cv2.bitwise_and(frame, frame, mask=fgMask)

            # Identify the ball
            mask,ball_boxes = ball_finder_yolov8(frame, model)
            # Canny edge detection
            edges = cv2.Canny(mask, 100, 200)
            # Find contours of the ball
            contours, hierarchy = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

            # Write frame number in top left
            cv2.rectangle(frame, (10, 2), (100, 20), (255, 255, 255), -1)
            cv2.putText(frame, str(cap.get(cv2.CAP_PROP_POS_FRAMES)), (15, 15),
                        cv2.FONT_HERSHEY_SIMPLEX, .5, (0, 0, 0))

            new_frame = cv2.drawContours(new_frame, contours, -1, (0, 255, 0), 3)

            # Get rid of excess contours and do analysis
            if len(contours) > 0:
                # Get the largest contour
                c = max(contours, key=cv2.contourArea)
                # Find the center of the ball
                M = cv2.moments(c)
                if M["m00"] != 0:
                    cX = int(M["m10"] / M["m00"])
                    cY = int(M["m01"] / M["m00"])
                else:
                    cX, cY = 0, 0
                center = (cX, cY)
                # Save the center coordinates to a list
                x_centers.append(center[0])
                y_centers.append(center[1])

                if len(contours) > 0:
                    c = max(contours, key=cv2.contourArea)
                    ((x, y), radius) = cv2.minEnclosingCircle(c)
                    center = (int(x), int(y))

                    if radius > 10:
                        x, y, w, h = cv2.boundingRect(c)
                        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
                        ball_radius = (w) * channels

                    if (
                            landmark_name == 'RIGHT_THUMB' or landmark_name == 'LEFT_THUMB' or
                            landmark_name == 'LEFT_PINKY' or landmark_name == 'RIGHT_PINKY' or
                            landmark_name == 'LEFT_WRIST' or landmark_name != 'RIGHT_WRIST'
                    ):
                        t_x = int(landmark_position.x * width)
                        t_y = int(landmark_position.y * height)
                        t_z = int(landmark_position.z)

                    hand_x = t_x
                    hand_y = t_y
                    hand_w = 10  # Largeur du rectangle des mains
                    hand_h = 10  # Hauteur du rectangle des mains

                    dist_hand_ball = math.sqrt((t_x - x) ** 2 + (t_y - y) ** 2 + (t_z - h) ** 2)

                    if dist_hand_ball > ball_radius:
                        peaks = peak_calculator(y_centers, int(peaks))
                    elif int(peaks)>7 and dist_hand_ball < ball_radius:

                            print("Touched by hand")
                            break

                        # Put number of peaks on frame
                        # cv2.putText(frame, "Counter: {}".format(peaks), (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)

            # # Display the resulting frame
            # cv2.imshow('Output', frame)


            print("peaks=",peaks)
            if len(ball_boxes) == 0:
                print("Aucun ball détecté dans le cadre.")
                continue
            end_time = time()
            fps = 1 / np.round(end_time - start_time, 2)
            ball_tracker.fps = fps

            # if len(ball_boxes) == 0:
            #     print("Aucun ball détecté dans le cadre.")
            #     continue
            ball_tracker.process_ball(ball_boxes)

            cv2.imshow('Output', frame)


        except Exception as e:
            print(f"Exception: {e}")
            break

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()
    if len(ball_tracker.ball_speeds) > 0:
        avg_speed = sum(ball_tracker.ball_speeds) / len(ball_tracker.ball_speeds)
        print("Average ball speed:", avg_speed, "pixels per second")

        resolution_ecran_pixels_par_metre = width
        taille_reelle_ballon_cm = 70

        # Calcul de la vitesse en mètres par seconde
        vitesse_metres_par_seconde = calculer_vitesse_metres_par_seconde(avg_speed,
                                                                         resolution_ecran_pixels_par_metre,
                                                                         taille_reelle_ballon_cm)
        print("la vitesse moyenne =", vitesse_metres_par_seconde, "m/s")
    return frame, peaks, vitesse_metres_par_seconde


from object_detection import ObjectDetection
from time import time
object_detector = ObjectDetection()
vitesse_metres_par_seconde=0

model = object_detector.load_model()
cap = cv2.VideoCapture(0)
# Call the jonglage function for real-time camera input
peaks, vitesse_metres_par_seconde = jonglage(model, cap)

print("peaks_total",peaks)
print("vitesse_moyenne",vitesse_metres_par_seconde)



