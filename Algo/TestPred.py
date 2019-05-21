from LMS import LMS
import numpy as np

def model_out(x,mu,sig,A):
	return A*np.exp(-(((x-mu)/sig)**2)/2)/(sig*np.sqrt(2*np.pi))

mu = -20
sig = 300
A = 10000

muHat = 1
sigHat = 1
AHat = 1

eta = 1
for i in range(1000):
	x = np.random.randint(-292,292)
	y = model_out(x,mu,sig,A)
	yHat = model_out(x,muHat,sigHat,AHat)
	e = y - yHat
	tempArr = np.array([muHat,sigHat,AHat]).reshape(3,1)
	tempArr = tempArr + eta*e*tempArr
	muHat = tempArr[0]
	sigHat = tempArr[1]
	AHat = tempArr[2]
	print(tempArr)
