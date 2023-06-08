import torch
import numpy as np
from ultralytics import YOLO
import supervision as sv

class ObjectDetection:
    def __init__(self):
        self.device = 'cuda' if torch.cuda.is_available() else 'cpu'
        print("Using Device:", self.device)
        self.model = self.load_model()
        self.CLASS_NAMES_DICT = self.model.model.names
        self.ball_boxes = []
        self.box_annotator = sv.BoxAnnotator(sv.ColorPalette.default(), thickness=3, text_thickness=3, text_scale=1.5)

    def load_model(self):
        model = YOLO("yolov8m.pt")  # load a pretrained YOLOv8n model
        model.fuse()
        return model

    def predict(self, frame):
        results = self.model(frame)
        return results

    def plot_bboxes(self, results, frame):
        xyxys = []
        confidences = []
        class_ids = []
        xyxy = []
        # Extract detections for person class
        for result in results:
            boxes = result.boxes.cpu().numpy()
            class_id = boxes.cls
            conf = boxes.conf
            xyxy = boxes.xyxy

            if any(class_id) == 0.0:
                xyxys.append(result.boxes.xyxy.cpu().numpy())
                confidences.append(result.boxes.conf.cpu().numpy())
                class_ids.append(result.boxes.cls.cpu().numpy().astype(int))

        # Setup detections for visualization
        detections = sv.Detections(
            xyxy=results[0].boxes.xyxy.cpu().numpy(),
            confidence=results[0].boxes.conf.cpu().numpy(),

            class_id=results[0].boxes.cls.cpu().numpy().astype(int),
        )

        for box, id in zip(xyxy, class_id):
            if id == 32:  # class 0 corresponds to ball (modify this if necessary)
                self.ball_boxes.append(box)

            else:
                break
        #print("ball_box", self.ball_boxes)

        # Annotate and display frame
        print('detections')
        print(class_id)
        print(type(xyxy))
        frame = self.box_annotator.annotate(scene=frame, detections=detections)
        return frame, box




# import cv2
# from object_detection import ObjectDetection
#
#
# # Load sample input data (frame)
# frame = cv2.imread("t.jpeg")
#
# # Create an instance of ObjectDetection
# object_detector = ObjectDetection()
#
# # Create an instance of ObjectDetection
# object_detector = ObjectDetection()
#
# # Predict and plot bounding boxes
# results = object_detector.predict(frame)
# print(results[0])
# frame_with_bboxes, box = object_detector.plot_bboxes(results, frame)
#
# # Save the frame with the ball box
# cv2.imwrite("output.jpg", frame_with_bboxes)
