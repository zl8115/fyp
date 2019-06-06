# Test Script that shows the captured image and allows for manipulation of the tunable lens in one program
# Commands are :
# "a/d" => +/- 10 mA
# "-/=" => +/- 1 mA
# "0"   => 0 mA
# "s"   => Scan [-290:10:290]
# "q"   => Quit

# import the necessary packages
from picamera.array import PiRGBArray
from picamera import PiCamera
import time
import cv2

# New Lines
from opto import Opto

o = Opto(port='/dev/ttyACM0')
o.connect()
scan = False
current = 0
o.current(current)

# initialize the camera and grab a reference to the raw camera capture
camera = PiCamera(sensor_mode=7)
camera.resolution = (640,480)
camera.framerate = 30
camera.color_effects = (128,128)
rawCapture = PiRGBArray(camera,size=(640,480))

# cv2 text overlay
font = cv2.FONT_HERSHEY_SIMPLEX
location1 = (10,20)
location2 = (10,40)
fontScale = 0.5
fontColor = (255,255,255)
lineType = 2
fps = 0
tList = []

# allow the camera to warmup
time.sleep(0.1)

tList.append(time.time())

# capture frames from the camera
for frame in camera.capture_continuous(rawCapture, format="bgr", use_video_port=True):
    # grab the raw NumPy array representing the image, then initialize the timestamp
    # and occupiued/unoccupied text
    image = frame.array
    tList.append(time.time())
    if len(tList) > 11:
        tList.pop(0)
    fps = 1/(sum([j-i for i, j in zip(tList[:-1], tList[1:])])/len(tList))

    text1 = "FPS: " + str(fps) 
    text2 = "Lens: " + str(current)
    # show the frame
    cv2.putText(image,text1,location1,font,fontScale,fontColor,lineType)
    cv2.putText(image,text2,location2,font,fontScale,fontColor,lineType)
    cv2.imshow("Frame", image)
    key = cv2.waitKey(1) & 0xFF

    # clear the stream in preperation for the next fram
    rawCapture.truncate(0)

    # if the 'q' key was pressed break from the loop
    if key == ord("q"):
        break
    elif key == ord("s"):
        scan = True
        current = -290
    elif key == ord("a"):
        current += -10
    elif key == ord("d"):
        current += 10
    elif key == ord("0"):
        current = 0
    elif key == ord("-"):
        current += -1
    elif key == ord("="):
        current += 1

    if scan:
        current += 10

    if current > 290 or current < -290:
        scan = False
    else:
        o.current(current)

o.close()