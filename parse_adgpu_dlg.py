import sys
import os
import csv
import pandas as pd

def parse_dirname(dirname):
	"""Parse folder name"""

	# IMPORTANT: adapt these indexes on a case basis
	index_in_foldername_test = 1
	index_in_foldername_version = 4
	index_in_foldername_device = 2

	# Actual parsing
	name_list = dirname.split('_')
	test = name_list[index_in_foldername_test]
	version = name_list[index_in_foldername_version]
	device = name_list[index_in_foldername_device]
	return test, version, device

def parse_filename(filename):
	"""Parse file names"""
	# IMPORTANT: adapt these indexes on a case basis
	index_in_filename_ls = 4
	index_in_filename_nwi = 2
	index_in_filename_pdb = 3

	# Actual parsing
	head, tail = os.path.split(filename)
	name_list = tail.replace('.', '_')
	name_list = name_list.split('_')
	#print("Filename: head = %s \ttail = %s" %(head, tail))
	#print(name_list)
	ls = name_list[index_in_filename_ls]
	nwi = name_list[index_in_filename_nwi]
	pdb = name_list[index_in_filename_pdb]
	return ls, nwi, pdb

def retrieve_runtime(filename):
	"""Retrieve runtime (s) from dlg files"""

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

def reorder_metafile(metafile):
	"""Reorder metafile according to number of work-items"""

	# IMPORTANT: adapt these indexes on a case basis
	index_pdb = 2
	index_numwi = 1
	index_runtime = 3

	num_pdbs = 5

	# --------------------------------------------------------------------
	# Sublists
	list_1u4d, list_1oyt, list_1mzc, list_3s8o, list_2d1o  = [['0', '0', '0', '0'] for i in range(num_pdbs)]

	for idx in metafile:
		pdb = idx[index_pdb]
		numwi = idx[index_numwi]
		runtime = idx[index_runtime]
		if pdb == '1u4d':
			if   numwi == '32wi' : list_1u4d[0] = idx
			elif numwi == '64wi' : list_1u4d[1] = idx
			elif numwi == '128wi': list_1u4d[2] = idx
			elif numwi == '256wi': list_1u4d[3] = idx
			else: print('error')
		elif pdb == '1oyt':
			if   numwi == '32wi' : list_1oyt[0] = idx
			elif numwi == '64wi' : list_1oyt[1] = idx
			elif numwi == '128wi': list_1oyt[2] = idx
			elif numwi == '256wi': list_1oyt[3] = idx
			else: print('error')
		elif pdb == '1mzc':
			if   numwi == '32wi' : list_1mzc[0] = idx
			elif numwi == '64wi' : list_1mzc[1] = idx
			elif numwi == '128wi': list_1mzc[2] = idx
			elif numwi == '256wi': list_1mzc[3] = idx
		elif pdb == '3s8o':
			if   numwi == '32wi' : list_3s8o[0] = idx
			elif numwi == '64wi' : list_3s8o[1] = idx
			elif numwi == '128wi': list_3s8o[2] = idx
			elif numwi == '256wi': list_3s8o[3] = idx
			else: print('error')
		elif pdb == '2d1o':
			if   numwi == '32wi' : list_2d1o[0] = idx
			elif numwi == '64wi' : list_2d1o[1] = idx
			elif numwi == '128wi': list_2d1o[2] = idx
			elif numwi == '256wi': list_2d1o[3] = idx
			else: print('error')
		else:
			print('error!, \t%s, \t%f' %(pdb, runtime))

	# --------------------------------------------------------------------
	# Sublists: pdb vs runtimes
	R_1u4d, R_1oyt, R_1mzc, R_3s8o, R_2d1o = [['0', '0', '0', '0', '0'] for i in range(num_pdbs)]
 
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
		R_1u4d[i+1] = list_1u4d[i][index_runtime]
		R_1oyt[i+1] = list_1oyt[i][index_runtime]
		R_1mzc[i+1] = list_1mzc[i][index_runtime]
		R_3s8o[i+1] = list_3s8o[i][index_runtime]
		R_2d1o[i+1] = list_2d1o[i][index_runtime]

	# --------------------------------------------------------------------

	reordered_metafile = []
	reordered_metafile = list_1u4d + list_1oyt + list_1mzc + list_3s8o + list_2d1o

	reordered_runtimes_metafile = []
	reordered_runtimes_metafile = [R_1u4d] + [R_1oyt] + [R_1mzc] + [R_3s8o] + [R_2d1o]

	#for idx_list in reordered_metafile:
	#	print(idx_list)

	#for idx_list in reordered_runtimes_metafile:
	#	print(idx_list)

	return reordered_metafile, reordered_runtimes_metafile

def main():
	# First argument is the folder containing .dlg files	
	dirname = sys.argv[1]

	test, folder_version, device = parse_dirname(dirname)
	#print(test, folder_version, device)

	list_files = os.listdir(dirname)
	#print(list_files)

	csv_sw_metafile = []
	csv_ad_metafile = []

	for filename in list_files:
		ls, nwi, pdb = parse_filename(dirname + '/' + filename)
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
	#with open('myresults_sw.csv', 'w', newline='') as file:
	#	writer = csv.writer(file)
	#	writer.writerow(["LS method", "Version", "NUMWI", "PDB", "Run time(s)"])
	#	for row in csv_ordered_sw_metafile:
	#		writer.writerow(row)

	#with open('myresults_ad.csv', 'w', newline='') as file:
	#	writer = csv.writer(file)
	#	writer.writerow(["LS method", "Version", "NUMWI", "PDB", "Run time(s)"])
	#	for row in csv_ordered_ad_metafile:
	#		writer.writerow(row)

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
