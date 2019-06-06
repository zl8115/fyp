import cv2
import time

while True:
	key = cv2.waitKey(1) & 0xFF
	if key == ord("q"):
		break
	elif key != 255:
		print(key)
	time.sleep(0.5)