import cooler
import h5py
class NormalizeRawContacts():
	def __init__(self, cool_file):
		if isinstance(cool_file, str):
			
