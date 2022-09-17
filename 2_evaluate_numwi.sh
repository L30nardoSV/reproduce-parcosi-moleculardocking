#!/bin/bash

AUXILIARY_SCRIPTS_DIR=auxiliary_scripts

source ${AUXILIARY_SCRIPTS_DIR}/common_functions.sh
source ${AUXILIARY_SCRIPTS_DIR}/experiments_dataset.sh
source ${AUXILIARY_SCRIPTS_DIR}/numwi.sh

ADGPU_CUDA_BINS=(./autodock_gpu_32wi_cuda ./autodock_gpu_64wi_cuda ./autodock_gpu_128wi_cuda ./autodock_gpu_256wi_cuda)
ADGPU_OPENCL_BINS=(./autodock_gpu_32wi_ocl ./autodock_gpu_64wi_ocl ./autodock_gpu_128wi_ocl ./autodock_gpu_256wi_ocl)
ADGPU_DPCPP_BINS=(./autodock_xegpu_32wi ./autodock_xegpu_64wi ./autodock_xegpu_128wi ./autodock_xegpu_256wi)

# Main execution
select_device
verify_binaries_exist_in_local_folder

(	# numwi test
	if [ "${TEST_GPU}" == "Y" ]; then
		if [ "${TEST_VERSION}" == "c" ]; then
			for i_adgpu_bin in ${ADGPU_CUDA_BINS[@]}; do
				numwi ${i_adgpu_bin}
			done
		elif [ "${TEST_VERSION}" == "o" ]; then
			for i_adgpu_bin in ${ADGPU_OPENCL_BINS[@]}; do
				numwi ${i_adgpu_bin}
			done
		elif [ "${TEST_VERSION}" == "d" ]; then
			for i_adgpu_bin in ${ADGPU_DPCPP_BINS[@]}; do
				numwi ${i_adgpu_bin}
			done
		fi
	fi
) 2>&1 | tee ${RES_GPU_DIR}.log
