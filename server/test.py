"""
importing the necessary libraries
"""
import numpy as np
import mediapipe as mp
import cv2

import math
from scipy.signal import find_peaks
from scipy.signal import savgol_filter

import torch



mp_drawing = mp.solutions.drawing_utils
mp_pose = mp.solutions.pose
pose = mp_pose.Pose(min_detection_confidence=0.5, min_tracking_confidence=0.5)


device = torch.device('cuda') if torch.cuda.is_available() else torch.device('cpu')

def ball_finder_yolov5(frame,model):
    """
    impute:frame & yolo_v5 model for detection
    output:detect and mask the ball area
    """
    # Convert BGR image to RGB
    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    # Run inference on the model
    outputs = model(frame)
    # Extract the bounding boxes and class probabilities for detected objects
    boxes = outputs.xyxy[0].cpu().numpy()
    preds = outputs.pred[0].cpu().numpy()
    # Filter out non-ball objects and low-confidence detections
    ball_boxes = []
    for box, score in zip(boxes, preds[:, 0]):
        if score > 0.5 and box[5] == 32:  # class 0 corresponds to ball
            ball_boxes.append(box)
# Create a binary mask for the ball objects
    mask = np.zeros(frame.shape[:2], dtype=np.uint8)
    mask = mask.reshape(frame.shape[:2])
    for box in ball_boxes:
        x1, y1, x2, y2 = box[:4]
        mask[int(y1):int(y2), int(x1):int(x2)] = 255
    return mask
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


def jonglage(model, frame):
    """
    Perform ball detection and juggling analysis on real-time camera input.
    """
    x_centers = []
    y_centers = []

    backSub = cv2.createBackgroundSubtractorKNN()
    background_subtract = True
    peaks = 0


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
    mask = ball_finder_yolov5(frame, model)
    # Canny edge detection
    edges = cv2.Canny(mask, 100, 200)
    # Find contours of the ball
    contours, hierarchy = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # Write frame number in top left
    cv2.rectangle(frame, (10, 2), (100, 20), (255, 255, 255), -1)
    # cv2.putText(frame, str(cap.get(cv2.CAP_PROP_POS_FRAMES)), (15, 15),
    #             cv2.FONT_HERSHEY_SIMPLEX, .5, (0, 0, 0))

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

                # Put number of peaks on frame
                # cv2.putText(frame, "Counter: {}".format(peaks), (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)


    #
    if ball_radius > dist_hand_ball and int(peaks) > 100:
         print("Touched by hand")
    return frame, peaks


    # return peaks
# model = torch.hub.load('ultralytics/yolov5', 'yolov5s', force_reload=False)
#
# # Set the device (CPU or GPU)
# device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
#
#
#
#
# # Call the jonglage function for real-time camera input
# peaks = jonglage(model, device)

