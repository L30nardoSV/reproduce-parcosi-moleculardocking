#!/bin/bash

source parcosi_dataset.sh
source numwi.sh

ADGPU_OPENCL_BINS=(./autodock_gpu_32wi ./autodock_gpu_64wi ./autodock_gpu_128wi ./autodock_gpu_256wi)

# Bash functions
function select_device() {
  echo " "
  echo "${info}: Selecting device to test with AutoDock-GPU."
  echo " "
  echo "${info}: GPU? "
  read -p "[Y]: " TEST_GPU
  if [ "${TEST_GPU}" == "Y" ]; then
    echo " "
    echo "${info}: Type a meaningful label for your GPU device."
    read -p "E.g.: [v100] [a100] [mi50] [mi100] [vega64] [etc]: " LABEL_GPU
    RES_GPU_DIR=results_numwi_${LABEL_GPU}
    if [ ! -d ${RES_GPU_DIR} ]; then
      mkdir ${RES_GPU_DIR}
    else
      echo "${info}: Be cautious. Folder \"${RES_GPU_DIR}\" for storing results already exists!"
    fi
  fi

  echo " "
  echo "${info}: Device(s) to be tested: "
  if [ "${TEST_GPU}" == "Y" ]; then
    echo "\"${LABEL_GPU}\" GPU "
  fi
  if [ "${TEST_GPU}" != "Y" ]; then
    echo "${info}: No device chosen."
    echo "${info}: Terminated."
    exit 9999 # Die with error code 9999
  fi
}

function verify_binaries_exist_in_local_folder() {
  echo " "
  echo "${info}: Verifying that AutoDock-GPU binaries are present in current folder."
  echo " "
  if [ "${TEST_GPU}" == "Y" ]; then
    for i_adgpu_bin in ${ADGPU_OPENCL_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
        echo "${info}: \"${i_adgpu_bin}\" exists."
        else
        echo "${info}: \"${i_adgpu_bin}\" does not exist. Make sure binary is copied over first!"
        echo "${info}: Terminated."
        exit 9999 # Die with error code 9999
        fi
    done
  fi
}

# Main execution
select_device
verify_binaries_exist_in_local_folder

# numwi test
if [ "${TEST_GPU}" == "Y" ]; then
    for i_adgpu_bin in ${ADGPU_OPENCL_BINS[@]}; do
        numwi ${i_adgpu_bin} ${RES_GPU_DIR}
    done
fi
