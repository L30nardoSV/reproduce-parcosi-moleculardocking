#!/bin/bash

source common_functions.sh
source parcosi_dataset.sh
source heuristics.sh

ADGPU_OPENCL_BINS=(./autodock_gpu_64wi_ocl)
ADGPU_CUDA_BINS=(./autodock_gpu_64wi_cuda)

# Main execution
select_device
verify_binaries_exist_in_local_folder

# heuristics test
if [ "${TEST_GPU}" == "Y" ]; then
  if [ "${TEST_CUDA}" == "Y" ]; then
    for i_adgpu_bin in ${ADGPU_CUDA_BINS[@]}; do
      heuristics ${i_adgpu_bin} ${RES_GPU_DIR} ${DEVNUM}
    done
  else
    for i_adgpu_bin in ${ADGPU_OPENCL_BINS[@]}; do
      heuristics ${i_adgpu_bin} ${RES_GPU_DIR} ${DEVNUM}
    done
  fi
fi