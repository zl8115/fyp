import numpy as np

class LMS(object):
	def __init__(self,inputOrder,outputOrder,learningRate):
		self.w = np.zeros(inputOrder,outputOrder)
		self.mu = learningRate
		self.prev = np.zeros(inputOrder-1,1)

	def learn(self,x,y):
		splicedx = np.append(x,self.prev)
		y_hat = np.dot(self.w.T,splicedx)
		e = y - y_hat
		self.w = w + self.mu*np.dot(splicedx,e.T)
		self.prev = np.delete(splicedx,1,-1)
		return y_hat

	def weights(self):
		return self.w