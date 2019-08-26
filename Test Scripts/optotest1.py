# Script2 to test the functionality of the Opto library from https://github.com/OrganicIrratiation/opto

from opto import Opto
import time
import numpy as np

o = Opto(port='/dev/ttyACM0')
o.connect()
print('Successfully Connected')
current_low = o.current_lower()
current_high = o.current_upper()
current_delta = current_high-current_low
print('Upper: ',current_high)
print('Lower: ',current_low)
o.close(soft_close=True)
