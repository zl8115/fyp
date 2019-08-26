# Script to remove all file in ./imgs/ directory

import os, shutil

folder = './imgs/'
for the_file in os.listdir(folder):
	file_path = os.path.join(folder, the_file)
	try:
		if os.path.isfile(file_path):
			os.unlink(file_path)
	except Exception as e:
			print(e)