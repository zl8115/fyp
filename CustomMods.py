# Required for PiVideoStream
from picamera.array import PiRGBArray
from picamera import PiCamera
from threading import Thread
import cv2

# Required for FPS
import time

class PiVideoStream:
	def __init__(self, resolution=(640,480),framerate=90):
		#initialize the camera and stream
		self.camera = PiCamera(sensor_mode=7)
		self.resolution = resolution
		self.framerate = framerate
		self.camera.color_effects = (128,128)
		self.rawCapture = PiRGBArray(self.camera, size=resolution)
		self.stream = self.camera.capture_continuous(self.rawCapture,format="bgr",use_video_port=True)

		# initialize the frame and the variable used to indicate if the thread should be stopped
		self.frame = None
		self.stopped = False

	def start(self):
		# start the thread to read frames from the video stream
		Thread(target=self.update, args=()).start()
		return self

	def update(self):
		for f in self.stream:
			# grab the frame from the stream and clear the stream in preperation for the next frame
			self.frame = f.array
			self.rawCapture.truncate(0)

			# if the thread indicator variable is set, stop the thread and resource camera resources
			if self.stopped:
				self.stream.close()
				self.rawCapture.close()
				self.camera.close()
				return

	def read(self):
		#return the frame most recently read
		return self.frame

	def stop(self):
		self.stopped = True
		
class FPS:
	def __init__(self):
		self.tstart = None
		self.tend = None
		self.numFrames = 0
		self.tList = []

	def start(self):
		self.tstart = time.time()
		self.update()
		return self

	def stop(self):
		self.tend = time.time()
		self.update()

	def update(self):
		self.numFrames += 1
		self.tList.append(time.time())
		if len(self.tList) > 11:
			self.tList.pop(0)
	
	def fps(self):
		return 1/(sum([j-i for i, j in zip(self.tList[:-1], self.tList[1:])])/len(self.tList))

	def elapsed(self):
		return (sum([j-i for i, j in zip(self.tList[:-1], self.tList[1:])])/len(self.tList))

	def totalElapsed(self):
		return (self.tend - self.tstart)

	def totalFps(self):
		return self.numFrames/self.elapsed()