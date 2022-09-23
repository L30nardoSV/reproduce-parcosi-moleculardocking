import sys
import os
import csv
import pandas as pd

def retrieve_runtime(filename):
	"""Retrieve runtime (s) from dlg"""

	with open(filename, "rt") as myfile:   # open file for reading text
		lines = myfile.readlines()
		found_keyword = False

		for line in lines:
			if line.startswith('Run time'):
				found_keyword = True
           
			if found_keyword:
				runtime = float(line[9:15])
				found_keyword = False
				#print(runtime)

	return runtime

def parse_dirname(dirname):
	name_list = dirname.split('_')
	test = name_list[1]
	version = name_list[2]
	device = name_list[3]
	return test, version, device

def parse_filename(filename):
	head, tail = os.path.split(filename)
	name_list = tail.replace('.', '_')
	name_list = name_list.split('_')
	#print("Filename head: %s" %(head))
	#print("Filename tail: %s" %(tail))
	#print(name_list)
	nwi = name_list[2]
	pdb = name_list[3]
	ls = name_list[4]
	return nwi, pdb, ls

def reorder_metafile(metafile):
	# --------------------------------------------------------------------
	# Sublists
	list_1u4d, list_1oyt, list_1mzc, list_3s8o, list_2d1o  = [['0', '0', '0', '0'] for i in range(5)]

	for idx in metafile:
		if idx[2] == '1u4d':
			if   idx[1] == '32wi' : list_1u4d[0] = idx
			elif idx[1] == '64wi' : list_1u4d[1] = idx
			elif idx[1] == '128wi': list_1u4d[2] = idx
			elif idx[1] == '256wi': list_1u4d[3] = idx
			else: print('error')
		elif idx[2] == '1oyt':
			if   idx[1] == '32wi' : list_1oyt[0] = idx
			elif idx[1] == '64wi' : list_1oyt[1] = idx
			elif idx[1] == '128wi': list_1oyt[2] = idx
			elif idx[1] == '256wi': list_1oyt[3] = idx
			else: print('error')
		elif idx[2] == '1mzc':
			if   idx[1] == '32wi' : list_1mzc[0] = idx
			elif idx[1] == '64wi' : list_1mzc[1] = idx
			elif idx[1] == '128wi': list_1mzc[2] = idx
			elif idx[1] == '256wi': list_1mzc[3] = idx
		elif idx[2] == '3s8o':
			if   idx[1] == '32wi' : list_3s8o[0] = idx
			elif idx[1] == '64wi' : list_3s8o[1] = idx
			elif idx[1] == '128wi': list_3s8o[2] = idx
			elif idx[1] == '256wi': list_3s8o[3] = idx
			else: print('error')
		elif idx[2] == '2d1o':
			if   idx[1] == '32wi' : list_2d1o[0] = idx
			elif idx[1] == '64wi' : list_2d1o[1] = idx
			elif idx[1] == '128wi': list_2d1o[2] = idx
			elif idx[1] == '256wi': list_2d1o[3] = idx
			else: print('error')
		else:
			print('error!, \t%s, \t%s' %(idx[3], idx[2]))

	#print(list_1u4d)
	#print(list_1oyt)
	#print(list_1mzc)
	#print(list_3s8o)
	#print(list_2d1o) 

	reordered_metafile = []
	reordered_metafile = list_1u4d + list_1oyt + list_1mzc + list_3s8o + list_2d1o

	# --------------------------------------------------------------------
	# Sublists: pdb vs runtimes
	R_1u4d, R_1oyt, R_1mzc, R_3s8o, R_2d1o = [['0', '0', '0', '0', '0'] for i in range(5)]
 
	R_1u4d[0] = '1u4d'
	R_1oyt[0] = '1oyt'
	R_1mzc[0] = '1mzc'
	R_3s8o[0] = '3s8o'
	R_2d1o[0] = '2d1o'

	# CAUTION
	# Might need to replaced range(4) for range(1),
	# as some folders contain results only for one case (numwi=32)
	# instead of four ones (numwi={32, 64, 128, 256})
	for i in range(4):
		R_1u4d[i+1] = list_1u4d[i][3]
		R_1oyt[i+1] = list_1oyt[i][3]
		R_1mzc[i+1] = list_1mzc[i][3]
		R_3s8o[i+1] = list_3s8o[i][3]
		R_2d1o[i+1] = list_2d1o[i][3]

	#print(R_1u4d)
	#print(R_1ywr)
	#print(R_5wlo)
	#print(R_1jyq)

	reordered_runtimes_metafile = []
	reordered_runtimes_metafile = [R_1u4d] + [R_1oyt] + [R_1mzc] + [R_3s8o] + [R_2d1o]
	return reordered_metafile, reordered_runtimes_metafile

def main():
	# First argument is the folder containing .dlg files	
	dirname = sys.argv[1]

	test, folder_version, device = parse_dirname(dirname)
	#print(test, version, device)

	list_files = os.listdir(dirname)
	#print(list_files)

	csv_sw_metafile = []
	csv_ad_metafile = []

	for filename in list_files:
		nwi, pdb, ls = parse_filename(dirname + '/' + filename)
		runtime = retrieve_runtime(dirname + '/' + filename)
		#print('%s, \t%s, \t%s, \t%6.2f' %(ls, nwi, pdb, runtime))
		csv_row = []
		csv_row.extend([ls, nwi, pdb, runtime])
		if ls == "sw":
			csv_sw_metafile.extend([csv_row])
		elif ls == "ad":
			csv_ad_metafile.extend([csv_row])

	#print(csv_sw_metafile)

	csv_ordered_sw_metafile = []
	csv_ordered_ad_metafile = []
	csv_ordered_sw_runtimes_metafile = []
	csv_ordered_ad_runtimes_metafile = []

	# CAUTION
	# Might need to comment one of the following two function calls
	# as there are cases where either SW or AD results are not present
	csv_ordered_sw_metafile, csv_ordered_sw_runtimes_metafile = reorder_metafile(csv_sw_metafile)
	csv_ordered_ad_metafile, csv_ordered_ad_runtimes_metafile = reorder_metafile(csv_ad_metafile)

	#print(csv_ordered_sw_metafile)
	#print(csv_ordered_ad_metafile)
	#print(csv_ordered_sw_runtimes_metafile)
	#print(csv_ordered_ad_runtimes_metafile)

	# Produce csv files with all details
#    with open('myresults_sw.csv', 'w', newline='') as file:
#        writer = csv.writer(file)
#        writer.writerow(["LS method", "Version", "NUMWI", "PDB", "Run time(s)"])
#        for row in csv_ordered_sw_metafile:
#            writer.writerow(row)
    
#    with open('myresults_ad.csv', 'w', newline='') as file:
#        writer = csv.writer(file)
#        writer.writerow(["LS method", "Version", "NUMWI", "PDB", "Run time(s)"])
#        for row in csv_ordered_ad_metafile:
#            writer.writerow(row)

	# Produce csv files only with runtimes only
	filename_sw = 'myresults_sw' + '_' + test + '_' + folder_version + '_' + device
	filename_ad = 'myresults_ad' + '_' + test + '_' + folder_version + '_' + device

	filename_sw_csv = filename_sw + '.csv'
	filename_ad_csv = filename_ad + '.csv'

	filename_sw_txt = filename_sw + '.txt'
	filename_ad_txt = filename_ad + '.txt'

	filename_sw_xlsx = filename_sw + '.xlsx'
	filename_ad_xlsx = filename_ad + '.xlsx'

	with open(filename_sw_csv, 'w', newline='') as file:
		writer = csv.writer(file)
		writer.writerow(["pdb", "32wi", "64wi", "128wi", "256wi"])
		for row in csv_ordered_sw_runtimes_metafile:
			writer.writerow(row)

	with open(filename_ad_csv, 'w', newline='') as file:
		writer = csv.writer(file)
		writer.writerow(["pdb", "32wi", "64wi", "128wi", "256wi"])
		for row in csv_ordered_ad_runtimes_metafile:
			writer.writerow(row)
    
	# Changing file extension: from csv into txt
	os.rename(filename_sw_csv, filename_sw_txt)
	os.rename(filename_ad_csv, filename_ad_txt)

	# Transforming files: from txt into excel
	pd.read_csv(filename_sw_txt, delimiter=",").to_excel(filename_sw_xlsx, index=False)
	pd.read_csv(filename_ad_txt, delimiter=",").to_excel(filename_ad_xlsx, index=False)

main()

# python3 parse_adgpu_dlg.py results_numwi_opencl_rtx2070super
