from picamera.array import PiRGBArray
from picamera import PiCamera
from opto import Opto
import time
import cv2
import numpy as np

fileDir = "./imgs/"

# Initialize Camera
camera = PiCamera()
camera.resolution = (640,480)
camera.framerate = 30


# Initialize Tunable Lens
o = Opto(port='/dev/ttyACM0')
o.connect()
o.current(0)

# Allow Camera to warmup
time.sleep(0.5)

# Loop Across all settings
for i in range(-290,291,5):
	o.current(i)
	time.sleep(0.5) # Allow for settling time of the tunable lens
	fileName = fileDir + str(i)
	image_avr = np.zeros((480, 640, 3))
	for j in range(0,30):
		rawCapture = PiRGBArray(camera,size=(640,480))
		camera.capture(rawCapture, format="bgr")
		image = rawCapture.array
		image_avr += image
	image_avr = image_avr/30
	cv2.imwrite(fileName + ".png",image)
	cv2.imwrite(fileName+"_avr.png",image_avr)