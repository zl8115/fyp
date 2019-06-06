from LMS import LMS
import numpy as np

def model_out(x,mu,sig,A):
	return A*np.exp(-(((x-mu)/sig)**2)/2)/(sig*np.sqrt(2*np.pi))

mu = -20
sig = 300
eta = 1/sig
A = 100

muHat = 1
sigHat = 1
etaHat = 1/sigHat
AHat = 1

eps = 100
for i in range(-292,293):
	#x = np.random.randint(-292,292)
	x = i
	y = model_out(x,mu,sig,A)
	yHat = model_out(x,muHat,sigHat,AHat)
	e = y - yHat
	tempArr = np.array([muHat,sigHat,AHat])
	delMuHat = (x-muHat)*yHat/sigHat
	delSigHat = -(1/sigHat**2)*(1-((x-muHat)/sigHat)**2)*yHat
	delAHat = yHat/AHat
	delArr = np.array([delMuHat, delSigHat, delAHat])
	updArr = tempArr + eps*e*delArr
	muHat = updArr[0]
	sigHat = updArr[1]
	etaHat = 1/sigHat
	AHat = updArr[2]
	print(updArr)