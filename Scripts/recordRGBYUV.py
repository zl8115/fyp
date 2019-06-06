from picamera.array import PiRGBArray
from picamera.array import PiYUVArray
from picamera import PiCamera
from opto import Opto
import time
import cv2
import numpy as np
import argparse

fileDir = "./imgs/"

# Initialize Arguments i.e Optotune Lens setting
ap = argparse.ArgumentParser()
ap.add_argument("-l", "--lens", type=int, default=0, help="Optotune Lens setting")
ap.add_argument("-d", "--display", type = int, default=-1, help="Whether or not frames should be displayed")
args = vars(ap.parse_args())

# Initialize Camera
camera = PiCamera(sensor_mode=7)
camera.color_effects = (128,128)
camera.resolution = (640,480)
camera.framerate = 30


# Initialize Tunable Lens
o = Opto(port='/dev/ttyACM0')
o.connect()
o.current(args['lens'])

# Allow Camera to warmup
time.sleep(0.5)

# Set up RGB and YUV Capture
rgbCapture = PiRGBArray(camera,size=(640,480))
yuvCapture = PiYUVArray(camera,size=(640,480))

t1 = time.time()
camera.capture(rgbCapture, format="bgr")
t2 = time.time()
camera.capture(yuvCapture, format="yuv")
t3 = time.time()

rgbImage = rgbCapture.array
yuvImage = yuvCapture.array

cv2.imwrite('RGB.png',rgbImage)
cv2.imwrite('YUV.png',yuvImage)
