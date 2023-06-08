import asyncio
import websockets
import cv2
import base64
import json
from count import jonglage
from object_detection import ObjectDetection

object_detector = ObjectDetection()
model = object_detector.load_model()

port = 5000

print("Started server on port : ", port)


import sched
import time

# Create a scheduler object
scheduler = sched.scheduler(time.time, time.sleep)

# Initialize the variables
variable1 = 0
variable2 = 0
variable3 = 0

def increment_variable1():
    # Increment variable1
    global variable1
    variable1 += 1

    # Print variable1
    print("Variable 1:", variable1)

    # Schedule the next increment after 5 seconds
    scheduler.enter(5, 1, increment_variable1)

def increment_variable2():
    # Increment variable2
    global variable2
    variable2 += 1

    # Print variable2
    print("Variable 2:", variable2)

    # Schedule the next increment after 10 seconds
    scheduler.enter(10, 1, increment_variable2)

def increment_variable3():
    # Increment variable3
    global variable3
    variable3 += 1

    # Print variable3
    print("Variable 3:", variable3)

    # Schedule the next increment after 15 seconds
    scheduler.enter(15, 1, increment_variable3)

# Schedule the initial increments
scheduler.enter(0, 1, increment_variable1)
scheduler.enter(0, 1, increment_variable2)
scheduler.enter(0, 1, increment_variable3)

# Start the scheduler

scheduler.run()

async def transmit(websocket, path):
    print("Client Connected !")
    await websocket.send("Connection Established")
    try:
        cap = cv2.VideoCapture(0)

        while cap.isOpened():

            # Preprocess the frame
            frame, peaks, speed = jonglage(model, cap)
            # Encode the frame
            encoded = cv2.imencode('.jpg', frame)[1]

            data = str(base64.b64encode(encoded))

            data = data[2:len(data) - 1]
            peaks_f= variable3+ (2*variable1) + (3*variable2)

            # # Create the JSON data
            allData = json.dumps({'vitesse_moyenne': speed ,'peaks_total': peaks_f, 'camera': data ,'peaks_total genaux':variable1,'peaks_total Tete':variable2,'peaks_total pied':variable3,})
    
            #allData = json.dumps({'peaks_total pied':variable2,'peaks_total': peaks_f, 'camera': data })
            # # Send the JSON data
            await websocket.send(allData)

            # cv2.imshow("Transimission", processed_frame)

            if cv2.waitKey(1) & 0xFF == ord('q'):
                break
        cap.release()
    except websockets.connection.ConnectionClosed as e:
        print("Client Disconnected !")
        cap.release()
    except:
        print("Someting went Wrong !")

# # Start the WebSocket server
start_server = websockets.serve(transmit, host="192.168.1.84", port= 5000)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
