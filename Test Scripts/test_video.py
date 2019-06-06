# Test Script that streams a video using RGB Array and CV2 (extracts an RGB array from each capture buffer)

# import the necessary packages
from picamera.array import PiRGBArray
from picamera import PiCamera
import time
import cv2

# initialize the camera and grab a reference to the raw camera capture
camera = PiCamera(sensor_mode=7)
camera.resolution = (640,480)
camera.framerate = 30
camera.color_effects = (128,128)
rawCapture = PiRGBArray(camera,size=(640,480))

# allow the camera to warmup
time.sleep(0.1)

# capture frames from the camera
for frame in camera.capture_continuous(rawCapture, format="bgr", use_video_port=True):
    # grab the raw NumPy array representing the image, then initialize the timestamp
    # and occupiued/unoccupied text
    image = frame.array

    # show the frame
    cv2.imshow("Frame", image)
    key = cv2.waitKey(1) & 0xFF

    # clear the stream in preperation for the next fram
    rawCapture.truncate(0)
    sign = 1

    # if the 'q' key was pressed break from the loop
    if key == ord("q"):
        break


