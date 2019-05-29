from picamera.array import PiRGBArray
from picamera import PiCamera
from opto import Opto
import time
import cv2
import numpy as np

fileDir = "./imgs/"

# Initialize Camera
camera = PiCamera(sensor_mode=7)
camera.color_effects = (128,128)
camera.resolution = (640,480)
camera.framerate = 30


# Initialize Tunable Lens
o = Opto(port='/dev/ttyACM0')
o.connect()
o.current(0)

# Allow Camera to warmup
time.sleep(0.5)

rate = []
tprev = time.time()
# Loop Across all settings
for i in range(-290,291,1):
	o.current(i)
	fileName = fileDir + str(i) + ".png"
	fileNameAvr = fileDir + str(i) + "_avr.png"
	rawCapture = PiRGBArray(camera,size=(640,480))
	camera.capture(rawCapture, format="bgr")
	image = rawCapture.array
	cv2.imwrite(fileName,image)
	tnow = time.time()
	rate.append(tnow-tprev)
	tprev = tnow
print(np.mean(rate))