# Import the necessary packages
from picamera.array import PiRGBArray
from picamera import PiCamera
import time
import cv2

# Initialize the camera and grab a reference to the raw camera capture
camera = PiCamera()
rawCapture = PiRGBArray(camera)

# allow the camera to warmup
time.sleep(1)

# grab an image from the camera
camera.capture(rawCapture, format="bgr")
image = rawCapture.array

# display tthe image on screen and wait for a keypress
cv2.imshow("Image",image)
cv2.waitKey(0)
