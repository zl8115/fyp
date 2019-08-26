from LMS import LMS
import numpy as np

def model_out(x,mu,sig,A,B):
	return A*np.exp(-(((x-mu)/sig)**2)/2)/(sig*np.sqrt(2*np.pi)) + B

mu = -20
sig = 100
eta = 1/sig
A = 10
B = 0

muHat = 1
sigHat = 2
AHat = 1
BHat = 1

eps = 0.005
for i in range(-292,293):
	x = np.random.randint(-292,292)
	x = i
	y = model_out(x,mu,sig,A,B)
	yHat = model_out(x,muHat,sigHat,AHat,BHat)
	e = y - yHat

	delMuHat = (x-muHat)*yHat/sigHat
	delSigHat = -(np.log(abs(sigHat))*(x-muHat)**2)*yHat/sigHat
	delAHat = yHat
	delBHat = 0

	tempArr = np.array([muHat,sigHat,AHat,BHat])
	delArr = np.array([delMuHat, delSigHat, delAHat, delBHat])
	updArr = tempArr + eps*e*delArr
	muHat = updArr[0]
	sigHat = updArr[1]
	AHat = updArr[2]
	BHat = updArr[3]
	print(updArr)