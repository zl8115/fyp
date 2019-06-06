# Script that uses the FPS boost via Threading of the class PiVideoStream

#from imutils.video.pivideostream import PiVideoStream
from CustomMods import PiVideoStream
from CustomMods import FPS
from opto import Opto
import argparse
import imutils
import time
import cv2

# Initialize Optotune Lens
o = Opto(port='/dev/ttyACM0')
o.connect()
scan = False
current = 0
o.current(current)

# cv2 text overlay
font = cv2.FONT_HERSHEY_SIMPLEX
location1 = (10,20)
location2 = (10,40)
fontScale = 0.5
fontColor = (255,255,255)
lineType = 2
fps = 0
tList = []

# Start the Video Stream using the class
vs = PiVideoStream(resolution=(640,480),framerate=90).start()
time.sleep(2.0)

# Create FPS counter
fps = FPS().start()

# Keep Looping until stop
while True:
	frame = vs.read()
	#frame = imutils.resize(frame, width=400)

	# FPS Counter
	fps.update()
	#fps = 1/(sum([j-i for i, j in zip(tList[:-1], tList[1:])])/len(tList))

	# CV2 Text Overlay
	text1 = "FPS: " + str(fps.fps()) 
	text2 = "Lens: " + str(current)
	cv2.putText(frame,text1,location1,font,fontScale,fontColor,lineType)
	cv2.putText(frame,text2,location2,font,fontScale,fontColor,lineType)

	# Show Captured Image
	cv2.imshow("Frame",frame)
	key = cv2.waitKey(1) & 0xFF

	# Keystroke Commands
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
cv2.destroyAllWindows()
vs.stop()