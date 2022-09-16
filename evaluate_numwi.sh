#!/bin/bash

AUXILIARY_SCRIPTS_DIR=auxiliary_scripts

source ${AUXILIARY_SCRIPTS_DIR}/common_functions.sh
source ${AUXILIARY_SCRIPTS_DIR}/experiments_dataset.sh
source ${AUXILIARY_SCRIPTS_DIR}/numwi.sh

ADGPU_OPENCL_BINS=(./autodock_gpu_32wi_ocl ./autodock_gpu_64wi_ocl ./autodock_gpu_128wi_ocl ./autodock_gpu_256wi_ocl)
ADGPU_CUDA_BINS=(./autodock_gpu_32wi_cuda ./autodock_gpu_64wi_cuda ./autodock_gpu_128wi_cuda ./autodock_gpu_256wi_cuda)

# Main execution
select_device
verify_binaries_exist_in_local_folder

# numwi test
if [ "${TEST_GPU}" == "Y" ]; then
  if [ "${TEST_CUDA}" == "Y" ]; then
    for i_adgpu_bin in ${ADGPU_CUDA_BINS[@]}; do
      numwi ${i_adgpu_bin} ${RES_GPU_DIR} ${DEVNUM}
    done
  else
    for i_adgpu_bin in ${ADGPU_OPENCL_BINS[@]}; do
      numwi ${i_adgpu_bin} ${RES_GPU_DIR} ${DEVNUM}
    done
  fi
fi
