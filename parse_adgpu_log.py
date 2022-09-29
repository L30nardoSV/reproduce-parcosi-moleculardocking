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

	label_time_docking = "Docking time"
	searchpattern_time_docking = "^" + label_time_docking
	index_time_docking = 2

	label_time_shutdown = "Shutdown time"
	searchpattern_time_shutdown = "^" + label_time_shutdown
	index_time_shutdown = 2

	label_time_processing = "Processing time"
	searchpattern_time_processing = "^" + label_time_processing
	index_time_processing = 2

	with open(filename, "rt") as myfile:	# open file for reading text
		lines = myfile.readlines()
#		found_new_measurement = False
#		count_new_measurement = 0

		for line in lines:
			found_time_restofsetup = re.search(searchpattern_time_restofsetup, line)
			found_time_docking = re.search(searchpattern_time_docking, line)
			found_time_shutdown = re.search(searchpattern_time_shutdown, line)
			found_time_processing = re.search(searchpattern_time_processing, line)

			if found_time_restofsetup:
				split_line = re.split("\s", line)
				time_restofsetup = split_line[index_time_restofsetup]
				print(label_time_restofsetup, ":\t", time_restofsetup)

			if found_time_docking:
				split_line = re.split("\s", line)
				time_docking = split_line[index_time_docking]
				print(label_time_docking, ":\t", time_docking)

			if found_time_shutdown:
				split_line = re.split("\s", line)
				time_shutdown = split_line[index_time_shutdown]
				print(label_time_shutdown, ":\t", time_shutdown)

			if found_time_processing:
				split_line = re.split("\s", line)
				time_processing = split_line[index_time_processing]
				print(label_time_processing, ":\t", time_processing)

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
