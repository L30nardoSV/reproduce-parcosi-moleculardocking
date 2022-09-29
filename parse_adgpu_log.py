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

def retrieve_runtimes(filename):
	"""Retrieve runtimes (s) from log file"""

	label_time_restofsetup = "Rest of Setup time"
	searchpattern_time_restofsetup = "^" + label_time_restofsetup
	index_time_restofsetup = 4

	with open(filename, "rt") as myfile:	# open file for reading text
		lines = myfile.readlines()
#		found_new_measurement = False
#		count_new_measurement = 0

		for line in lines:
#			found_time_restofsetup = re.search("^Rest of Setup time", line)
			found_time_restofsetup = re.search(searchpattern_time_restofsetup, line)
			found_time_docking = re.search("^Docking time", line)
			found_time_shutdown = re.search("^Shutdown time", line)
			found_time_processing = re.search("^Processing time", line)

			if found_time_restofsetup:
				split_line = re.split("\s", line)
				time_restofsetup = split_line[index_time_restofsetup]
				print(label_time_restofsetup, ": ", time_restofsetup)

			if found_time_docking:
				print("found_time_docking")

			if found_time_shutdown:
				print("found_time_shutdown")

			if found_time_processing:
				print("found_time_processing")

#			if line.startswith('+ ./autodock_gpu_'):
#				found_new_measurement = True
#				count_new_measurement = count_new_measurement + 1
#				print("count_new_measurement: ", count_new_measurement)



def main():
	# First argument is the log file
	log_file = sys.argv[1]
	parse_filename(log_file)
	retrieve_runtimes(log_file)

main()

#python3 parse_adgpu_log.py <log_file>
