import websockets
import asyncio
import torch
from test import jonglage

import cv2, base64
import json


model = torch.hub.load('ultralytics/yolov5', 'yolov5s', force_reload=False)

# Set the device (CPU or GPU)
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
port = 5000

print("Started server on port : ", port)

async def transmit(websocket, path):
    print("Client Connected !")
    await websocket.send("Connection Established")
    try:
        cap = cv2.VideoCapture(0)  # Use the default camera (change the index if you have multiple cameras)

        # Check if camera opened successfully
        if not cap.isOpened():
            print("Error opening camera")
            return

        while cap.isOpened():
            _, frame = cap.read()

            frame, count_j = jonglage(model, frame)
            encoded = cv2.imencode('.jpg', frame)[1]

            data = str(base64.b64encode(encoded))

            data = data[2:len(data) - 1]
            print(count_j)
            allData = json.dumps({'count_jonglage': count_j , 'camera': data})
            #allData = json.dumps({'vitesse_moyenne': speed ,'peaks_total': peaks, 'camera': data})


            
           
    
            #await websocket.send(data)
            await websocket.send(allData)

#cv2.imshow("Transimission", frame)

            #if cv2.waitKey(1) & 0xFF == ord('q'):
                #break
        cap.release()
    except websockets.connection.ConnectionClosed as e:
        print("Client Disconnected !")
        cap.release()
    except:
        print("Someting went Wrong !")


start_server = websockets.serve(transmit, host="192.168.1.84", port=5000)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()








