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

	# Metacharacter "+" is escaped with preceding "\"
	label_start_measurement = "\+ ./autodock_"
	searchpattern_start_measurement = "^" + label_start_measurement
	index_cmd_name_dlg = -4 # Starts count from last element

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
				split_line = re.split("\s", line)
				name_dlg = split_line[index_cmd_name_dlg]
				name_dlg = re.split("_", name_dlg)
				print(split_line)
				print(name_dlg)

				found_new_measurement = True
				count_new_measurement = count_new_measurement + 1
				print("count_new_measurement: ", count_new_measurement)

			if found_time_setup:
				split_line = re.split("\s", line)
				if split_line[0] != "Rest":	# Avoids matching pattern "found_time_restofsetup"
					time_setup = split_line[index_time_setup]
					time_setup = re.sub("s$", " ", time_setup) # Replaces trailing "s" character with blank space
					print(split_line[0] + " " + label_time_setup, ":\t", time_setup) # Prints CUDA/OpenCL/DPC++ label at the beginning

			if found_time_restofsetup:
				split_line = re.split("\s", line)
				time_restofsetup = split_line[index_time_restofsetup]
				time_restofsetup = re.sub("s$", " ", time_restofsetup) # Replaces trailing "s" character with blank space
				print(label_time_restofsetup, ":\t", time_restofsetup)

			if found_time_docking:
				split_line = re.split("\s", line)
				time_docking = split_line[index_time_docking]
				time_docking = re.sub("s$", " ", time_docking) # Replaces trailing "s" character with blank space
				print(label_time_docking, ":\t", time_docking)

			if found_time_shutdown:
				split_line = re.split("\s", line)
				time_shutdown = split_line[index_time_shutdown]
				time_shutdown = re.sub("s$", " ", time_shutdown) # Replaces trailing "s" character with blank space
				print(label_time_shutdown, ":\t", time_shutdown)

			if found_time_job:
				split_line = re.split("\s", line)
				time_job = split_line[index_time_job]
				time_job_wait = split_line[index_time_job_wait]
				print("Job time & wait time", ":\t", time_job, "\t", time_job_wait)

			if found_time_processing:
				split_line = re.split("\s", line)
				time_processing = split_line[index_time_processing]
				print(label_time_processing, ":\t", time_processing)

def main():
	# First argument is the log file
	log_file = sys.argv[1]
	parse_filename(log_file)
	retrieve_runtimes(log_file)

main()

#python3 parse_adgpu_log.py <log_file>
