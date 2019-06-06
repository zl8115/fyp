# Script used to tune lens using the CMD

from opto import Opto
import time

o = Opto(port='/dev/ttyACM0')
o.connect()
print('Successfully Connected')

current_low = -285
current_high = 285
current_delta = current_high-current_low
print('Upper: ',current_high)
print('Lower: ',current_low)
print('Input \'q\' to exit')

while True:
	key = input("Current:")
	try:
		key = float(key)
		if key > current_low and key < current_high:
			o.current(key)
		elif key < current_low:
			o.current(current_low)
		elif key > current_high:
			o.current(current_high)
	except ValueError:		
		if key == "q" or key =="Q" or key == "Quit" or key == "quit" or key == "QUIT":
			o.current(0)
			break
		elif key == "scan":
			for i in range(-290,291,10):
				o.current(i)
				time.sleep(0.25)
				print(i)

o.close(soft_close=True)