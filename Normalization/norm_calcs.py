import h5py
import dask.dataframe as daskdf
class NormalizeRawContacts():
    def __init__(self, cool_file):
        if isinstance(cool_file, str):
            self.dd = daskdf.read_hdf(cool_file, '/pixels/count')
        else:
            print('Pass in .cool filename')
            exit()

n = NormalizeRawContacts('s38_221203_Granta519EBF1KI_cl27_0hr_MicroC_25U_Nova_5000.cool')
print(n.dd)
