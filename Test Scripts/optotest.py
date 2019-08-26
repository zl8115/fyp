# Script to test the functionality of the Opto library from https://github.com/OrganicIrratiation/opto

from opto import Opto
import numpy as np
import time

with Opto(port='/dev/ttyACM0') as o:
    current_low = o.current_lower()
    current_high = o.current_upper()
    current_delta = current_high-current_low
    for i in np.linspace(0, 2*np.pi, 1000):
        o.current(np.sin(i)*current_delta+current_low)
        time.sleep(0.01)