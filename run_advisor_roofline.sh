#!/bin/bash

#set -o xtrace

pdb=1mzc
input_path=ad-gpu_miniset_20/data/${pdb}
input_protein=${input_path}/protein.maps.fld
input_ligand=${input_path}/rand-0.pdbqt

warning_message() {
	printf "\nMake sure that:"
	printf "\n - the AutoDock-GPU executables are copied into this folder"
	printf "\n - these code versions were compiled for __debug__"
	printf "\n   -- DPCPP : make DEVICE=XeGPU NUMWI=64 CONFIG=FDEBUG_VTUNE"
	printf "\n   -- OpenCL: make DEVICE=OCLGPU NUMWI=64 CONFIG=FDEBUG"
	printf "\n"
	sleep 1
}

init_tool() {
	# Initializing oneAPI tools
	printf "\n"
	source "/opt/intel/oneapi/setvars.sh"
}

choose_codeversion() {
	printf "\nChoose between DPCPP or OpenCL version:"
	printf "\n - [d] DPCPP"
	printf "\n - [o] OpenCL"
	printf "\n"
	read -p "Type either [d] or [o]: " CHOSEN_CODEVERSION

	if [ "${CHOSEN_CODEVERSION}" == "d" ]; then
		printf "\nChosen code version: DPCPP \n"
	elif [ "${CHOSEN_CODEVERSION}" == "o" ]; then
		printf "\nChosen code version: OpenCL \n"
	else
		printf "\nWrong selection. Type either [d] or [o] -> terminating!"
		printf "\n" && echo $0 && exit 1
	fi

	printf "\nSolis-Wets will be run by default. Do you __also__ want to run ADADELTA?"
	printf "\n"
	read -p "Type either [y] or [n]: " RUN_ALSO_ADADELTA

	if [ "${RUN_ALSO_ADADELTA}" == "y" ]; then
		printf "\nWe will profile both Solis-Wets and ADADELTA \n"
	elif [ "${RUN_ALSO_ADADELTA}" == "n" ]; then
		printf "\nWe will profile only Solis-Wets \n"
	else
		printf "\nWrong selection. Type either [y] or [n] -> terminating!"
		printf "\n" && echo $0 && exit 1
	fi
	sleep 1
}

define_executable() {
	if [ "${CHOSEN_CODEVERSION}" == "d" ]; then
		adgpu_binary=./autodock_xegpu_64wi
		output_mainfolder=DPCPP
	elif [ "${CHOSEN_CODEVERSION}" == "o" ]; then
		adgpu_binary=./autodock_gpu_64wi
		output_mainfolder=OpenCL
	fi
	sleep 1

	if [ -f "${adgpu_binary}" ]; then
		printf "${adgpu_binary} exists!\n"
	else
		printf "${adgpu_binary} does NOT exist -> terminating!\n"
		printf "\n" && echo $0 && exit 1
	fi

	adgpu_cmd_sw="${adgpu_binary} -ffile ${input_protein} -lfile ${input_ligand} -nrun 20 -lsmet sw --heuristics 0 --autostop 0"
	adgpu_cmd_ad="${adgpu_binary} -ffile ${input_protein} -lfile ${input_ligand} -nrun 20 -lsmet ad --heuristics 0 --autostop 0"

	printf "\nAutoDock-GPU commands: "
	printf "\n${adgpu_cmd_sw}"
	if [ "${RUN_ALSO_ADADELTA}" == "y" ]; then
		printf "\n${adgpu_cmd_ad}"
	fi
	sleep 1
}

print_cmd () {
	printf "\n$1\n"
}

run_cmd () {
	print_cmd "$1"
	$1
}

run_gpu_roofline() {
	printf "\n"
	printf "\n------------------------------------------------\n"
	printf "run_gpu_roofline() ..."
	printf "\n------------------------------------------------\n"
	output_folder_sw="${output_mainfolder}/r_gpu-roofline_${pdb}_sw"
	output_folder_ad="${output_mainfolder}/r_gpu-roofline_${pdb}_ad"

	cmd_roofline_shorcut="advisor --collect=roofline --profile-gpu"
	cmd_perfmodeling="advisor --collect=projection --profile-gpu --model-baseline-gpu"

	cmd_roofline_sw_1="${cmd_roofline_shorcut} --project-dir=${output_folder_sw} -- ${adgpu_cmd_sw}"
	cmd_roofline_sw_2="${cmd_perfmodeling} --project-dir=${output_folder_sw}"
	
	cmd_roofline_ad_1="${cmd_roofline_shorcut} --project-dir=${output_folder_ad} -- ${adgpu_cmd_ad}"
	cmd_roofline_ad_2="${cmd_perfmodeling} --project-dir=${output_folder_ad}"

#	local cmd_local_sw="${cmd_roofline_sw_1} && ${cmd_roofline_sw_2}"
#	local cmd_local_ad="${cmd_roofline_ad_1} && ${cmd_roofline_ad_2}"
#	run_cmd "${cmd_local_sw}" "${cmd_local_ad}"

	run_cmd "${cmd_roofline_sw_1}"
	run_cmd "${cmd_roofline_sw_2}"

	if [ "${RUN_ALSO_ADADELTA}" == "y" ]; then
		run_cmd "${cmd_roofline_ad_1}"
		run_cmd "${cmd_roofline_ad_2}"
	fi
}


warning_message
init_tool
choose_codeversion
define_executable
run_gpu_roofline
