import sys
import os
import re

def parse_filename(filename):
	"""Parse file name"""

	# Actual parsing
	head, tail = os.path.split(filename)
	name_field_list = tail.replace('.', '_')
	name_field_list = name_field_list.split('_')
	print(name_field_list)

def retrieve_runtimes(filename, is_print_enabled):
	"""Retrieve runtimes (s) from log file"""

	# Metacharacter "+" is escaped with preceding "\"
	label_start_measurement = "\+ ./autodock_"
	searchpattern_start_measurement = "^" + label_start_measurement
	index_cmd_name_dlg = -4 # Negative index: starts count from last element

	# *.dlg filename is parsed to extract execution information
	index_dlg_device = 5
	index_dlg_numwi = 6
	index_dlg_version = 7
	index_dlg_pdb = 8
	index_dlg_ls = 9

	# Metacharacter "." matches any character except newline character
	label_time_setup = "Setup time"
	searchpattern_time_setup = "." + label_time_setup
	index_time_setup = 3

	# Metacharacter "^" searches for a line starting with a given pattern
	label_time_restofsetup = "Rest of Setup time"
	searchpattern_time_restofsetup = "^" + label_time_restofsetup
	index_time_restofsetup = 4

	label_time_docking = "Docking time"
	searchpattern_time_docking = "^" + label_time_docking
	index_time_docking = 2

	label_time_shutdown = "Shutdown time"
	searchpattern_time_shutdown = "^" + label_time_shutdown
	index_time_shutdown = 2

	label_time_job = "Job #[0-9]"
	searchpattern_time_job = "^" + label_time_job
	index_time_job = 3
	index_time_job_wait = 7

	label_time_processing = "Processing time"
	searchpattern_time_processing = "^" + label_time_processing
	index_time_processing = 2

	# Lists for collecting all measurements
	num_of_entries_per_dlg = 40
	num_measurements_per_entry = 12
	num_elements_per_entry = num_measurements_per_entry
	list_measurements = [['0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'] for i in range(num_of_entries_per_dlg)]
	#print(list_measurements)

	with open(filename, "rt") as myfile:	# open file for reading text
		lines = myfile.readlines()
		found_new_measurement = False
		count_new_measurement = 0

		for line in lines:
			found_start_measurement = re.search(searchpattern_start_measurement, line)
			found_time_setup = re.search(searchpattern_time_setup, line)
			found_time_restofsetup = re.search(searchpattern_time_restofsetup, line)
			found_time_docking = re.search(searchpattern_time_docking, line)
			found_time_shutdown = re.search(searchpattern_time_shutdown, line)
			found_time_job = re.search(searchpattern_time_job, line)
			found_time_processing = re.search(searchpattern_time_processing, line)

			if found_start_measurement:
				print("\n")
				found_new_measurement = True
				print("# measurement: ", count_new_measurement)

				split_line = re.split("\s", line) # Splits AD-GPU command based on the blank space character
				name_dlg = split_line[index_cmd_name_dlg]
				name_dlg = re.split("_", name_dlg) # Splits dlg filename based on the underscore "_" character
				device = name_dlg[index_dlg_device]
				numwi = name_dlg[index_dlg_numwi]
				version = name_dlg[index_dlg_version]
				pdb = name_dlg[index_dlg_pdb]
				ls = name_dlg[index_dlg_ls]
				list_measurements[count_new_measurement][0] = device
				list_measurements[count_new_measurement][1] = numwi
				list_measurements[count_new_measurement][2] = version
				list_measurements[count_new_measurement][3] = pdb
				list_measurements[count_new_measurement][4] = ls
				if (is_print_enabled == True):
					print("Device:\t", device)
					print("NUMWI:\t", numwi)
					print("Version:\t", version)
					print("Test case:\t", pdb)
					print("Local search:\t", ls)

			if found_time_setup:
				split_line = re.split("\s", line)
				if split_line[0] != "Rest":	# Avoids matching pattern "found_time_restofsetup"
					time_setup = split_line[index_time_setup]
					time_setup = re.sub("s$", " ", time_setup) # Replaces trailing "s" character with blank space
					list_measurements[count_new_measurement][5] = time_setup
					if (is_print_enabled == True):
						print(split_line[0] + " " + label_time_setup, ":\t", time_setup) # Prints CUDA/OpenCL/DPC++ label at the beginning

			if found_time_restofsetup:
				split_line = re.split("\s", line)
				time_restofsetup = split_line[index_time_restofsetup]
				time_restofsetup = re.sub("s$", " ", time_restofsetup) # Replaces trailing "s" character with blank space
				list_measurements[count_new_measurement][6] = time_restofsetup
				if (is_print_enabled == True):
					print(label_time_restofsetup, ":\t", time_restofsetup)

			if found_time_docking:
				split_line = re.split("\s", line)
				time_docking = split_line[index_time_docking]
				time_docking = re.sub("s$", " ", time_docking) # Replaces trailing "s" character with blank space
				list_measurements[count_new_measurement][7] = time_docking
				if (is_print_enabled == True):
					print(label_time_docking, ":\t", time_docking)

			if found_time_shutdown:
				split_line = re.split("\s", line)
				time_shutdown = split_line[index_time_shutdown]
				time_shutdown = re.sub("s$", " ", time_shutdown) # Replaces trailing "s" character with blank space
				list_measurements[count_new_measurement][8] = time_shutdown
				if (is_print_enabled == True):
					print(label_time_shutdown, ":\t", time_shutdown)

			if found_time_job:
				split_line = re.split("\s", line)
				time_job = split_line[index_time_job]
				time_job_wait = split_line[index_time_job_wait]
				list_measurements[count_new_measurement][9] = time_job
				list_measurements[count_new_measurement][10] = time_job_wait
				if (is_print_enabled == True):
					print("Job time", ":\t", time_job)
					print("Job wait time", ":\t", time_job_wait)

			if found_time_processing:
				split_line = re.split("\s", line)
				time_processing = split_line[index_time_processing]
				list_measurements[count_new_measurement][11] = time_processing
				if (is_print_enabled == True):
					print(label_time_processing, ":\t", time_processing)

				if found_new_measurement == True:
					print(list_measurements[count_new_measurement])
					found_new_measurement = False
					count_new_measurement = count_new_measurement + 1

	return list_measurements

def group_measurements(measurements):
	#print(measurements)

	# Indexes within measurement lists
	index_device = 0
	index_numwi = 1
	index_version = 2
	index_pdb = 3
	index_ls = 4
	index_time_setup = 5
	index_time_restofsetup = 6
	index_time_docking = 7
	index_time_shutdown = 8
	index_time_job = 9
	index_time_job_wait = 10
	index_processing = 11

	# Sublists for Solis-Wets & ADADELTA
	# Each sublist carries results for 32wi, 64wi, 128wi, 256wi
	num_pdbs = 5
	list_sw_1u4d, list_sw_1oyt, list_sw_1mzc, list_sw_3s8o, list_sw_2d1o  = [['0', '0', '0', '0'] for i in range(num_pdbs)]
	list_ad_1u4d, list_ad_1oyt, list_ad_1mzc, list_ad_3s8o, list_ad_2d1o  = [['0', '0', '0', '0'] for i in range(num_pdbs)]

	for idx in measurements:
		pdb = idx[index_pdb]
		numwi = idx[index_numwi]
		ls = idx[index_ls]
		time_docking = idx[index_time_docking]

		if ls == 'sw':
			if pdb == '1u4d':
				if   numwi == '32wi' : list_sw_1u4d[0] = idx
				elif numwi == '64wi' : list_sw_1u4d[1] = idx
				elif numwi == '128wi': list_sw_1u4d[2] = idx
				elif numwi == '256wi': list_sw_1u4d[3] = idx
				else: print('error')
			elif pdb == '1oyt':
				if   numwi == '32wi' : list_sw_1oyt[0] = idx
				elif numwi == '64wi' : list_sw_1oyt[1] = idx
				elif numwi == '128wi': list_sw_1oyt[2] = idx
				elif numwi == '256wi': list_sw_1oyt[3] = idx
				else: print('error')
			elif pdb == '1mzc':
				if   numwi == '32wi' : list_sw_1mzc[0] = idx
				elif numwi == '64wi' : list_sw_1mzc[1] = idx
				elif numwi == '128wi': list_sw_1mzc[2] = idx
				elif numwi == '256wi': list_sw_1mzc[3] = idx
				else: print('error')
			elif pdb == '3s8o':
				if   numwi == '32wi' : list_sw_3s8o[0] = idx
				elif numwi == '64wi' : list_sw_3s8o[1] = idx
				elif numwi == '128wi': list_sw_3s8o[2] = idx
				elif numwi == '256wi': list_sw_3s8o[3] = idx
				else: print('error')
			elif pdb == '2d1o':
				if   numwi == '32wi' : list_sw_2d1o[0] = idx
				elif numwi == '64wi' : list_sw_2d1o[1] = idx
				elif numwi == '128wi': list_sw_2d1o[2] = idx
				elif numwi == '256wi': list_sw_2d1o[3] = idx
				else: print('error')
			else:
				print('error!, \t%s, \t%f' %(pdb, time_docking))
		elif ls == 'ad':
			if pdb == '1u4d':
				if   numwi == '32wi' : list_ad_1u4d[0] = idx
				elif numwi == '64wi' : list_ad_1u4d[1] = idx
				elif numwi == '128wi': list_ad_1u4d[2] = idx
				elif numwi == '256wi': list_ad_1u4d[3] = idx
				else: print('error')
			elif pdb == '1oyt':
				if   numwi == '32wi' : list_ad_1oyt[0] = idx
				elif numwi == '64wi' : list_ad_1oyt[1] = idx
				elif numwi == '128wi': list_ad_1oyt[2] = idx
				elif numwi == '256wi': list_ad_1oyt[3] = idx
				else: print('error')
			elif pdb == '1mzc':
				if   numwi == '32wi' : list_ad_1mzc[0] = idx
				elif numwi == '64wi' : list_ad_1mzc[1] = idx
				elif numwi == '128wi': list_ad_1mzc[2] = idx
				elif numwi == '256wi': list_ad_1mzc[3] = idx
				else: print('error')
			elif pdb == '3s8o':
				if   numwi == '32wi' : list_ad_3s8o[0] = idx
				elif numwi == '64wi' : list_ad_3s8o[1] = idx
				elif numwi == '128wi': list_ad_3s8o[2] = idx
				elif numwi == '256wi': list_ad_3s8o[3] = idx
				else: print('error')
			elif pdb == '2d1o':
				if   numwi == '32wi' : list_ad_2d1o[0] = idx
				elif numwi == '64wi' : list_ad_2d1o[1] = idx
				elif numwi == '128wi': list_ad_2d1o[2] = idx
				elif numwi == '256wi': list_ad_2d1o[3] = idx
				else: print('error')
			else:
				print('error!, \t%s, \t%f' %(pdb, time_docking))
		else:
			print('error!, \t%s' %(ls))

	# Reorder docking times


def main():
	# First argument is the log file
	log_file = sys.argv[1]
	parse_filename(log_file)

	# Extract measurements
	measurements = []
	measurements = retrieve_runtimes(log_file, False) # True

	# Group measurements
	group_measurements(measurements)

main()

#python3 parse_adgpu_log.py <log_file>
