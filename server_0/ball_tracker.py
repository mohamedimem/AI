import math


class BallTracker:
    def __init__(self, fps):
        self.previous_ball_center = None
        self.ball_speeds = []
        self.fps = fps
        self.vitesse_metres_par_seconde = 0

    def process_ball(self, xyxy):
        ball_center = ((xyxy[0] + xyxy[2]) / 2, (xyxy[1] + xyxy[3]) / 2)
        ball_radius = math.sqrt((xyxy[2] - xyxy[1]) * (xyxy[3] - xyxy[1])) / 2

        if self.previous_ball_center:
            speed = math.sqrt(
                (ball_center[0] - self.previous_ball_center[0]) ** 2 + (ball_center[1] - self.previous_ball_center[1]) ** 2)
            self.ball_speeds.append(speed * self.fps)

        self.previous_ball_center = ball_center
