#!/bin/bash

AUXILIARY_SCRIPTS_DIR=auxiliary_scripts

source ${AUXILIARY_SCRIPTS_DIR}/common_functions.sh
source ${AUXILIARY_SCRIPTS_DIR}/experiments_dataset.sh
source ${AUXILIARY_SCRIPTS_DIR}/numwi.sh

ADGPU_CUDA_BINS=(./autodock_gpu_32wi_cuda ./autodock_gpu_64wi_cuda ./autodock_gpu_128wi_cuda ./autodock_gpu_256wi_cuda)
ADGPU_OPENCL_BINS=(./autodock_gpu_32wi_ocl ./autodock_gpu_64wi_ocl ./autodock_gpu_128wi_ocl ./autodock_gpu_256wi_ocl)
ADGPU_OPENCL_CPU_BINS=(./autodock_cpu_32wi_ocl ./autodock_cpu_64wi_ocl ./autodock_cpu_128wi_ocl ./autodock_cpu_256wi_ocl)
ADGPU_DPCPP_BINS=(./autodock_xegpu_32wi_dpcpp ./autodock_xegpu_64wi_dpcpp ./autodock_xegpu_128wi_dpcpp ./autodock_xegpu_256wi_dpcpp)

# Main execution
select_device
verify_binaries_exist_in_local_folder

(	# numwi test
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
) 2>&1 | tee ${RES_DIR}.log
