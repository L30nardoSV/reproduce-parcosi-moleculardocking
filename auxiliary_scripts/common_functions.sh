#!/bin/bash

# Bash functions
function select_device() {
  echo " "
  echo "${info}: Selecting device to test with AutoDock-GPU."
  echo " "
  echo "${info}: GPU? "
  read -p "[Y]: " TEST_GPU
  echo "${info}: CUDA? "
  read -p "[Y]: " TEST_CUDA
  echo "${info}: OpenCL? "
  read -p "[Y]: " TEST_OPENCL
  echo "${info}: DPC++? "
  read -p "[Y]: " TEST_DPCPP

  DEVNUM=${DEVNUM: 1}
  echo "${info}: DEVNUM? (starts at 1)"
  read -p "[<1> or <2> or <3> or etc]: " DEVNUM

  if [ "${TEST_GPU}" == "Y" ]; then
    echo " "
    echo "${info}: Type a meaningful label for your GPU device."
    read -p "E.g.: [v100] [a100] [mi50] [mi100] [vega64] [etc]: " LABEL_GPU

    if [ "${TEST_CUDA}" == "Y" ]; then
      RES_GPU_DIR=results_numwi_cuda_${LABEL_GPU}
	elif [ "${TEST_OPENCL}" == "Y" ]; then
      RES_GPU_DIR=results_numwi_opencl_${LABEL_GPU}
	elif [ "${TEST_DPCPP}" == "Y" ]; then
      RES_GPU_DIR=results_numwi_dpcpp_${LABEL_GPU}
    else
      echo "${info}: No code version chosen."
      echo "${info}: Terminated."
      exit 9999 # Die with error code 9999
    fi

    if [ ! -d ${RES_GPU_DIR} ]; then
      mkdir ${RES_GPU_DIR}
    else
      echo "${info}: Be cautious. Folder \"${RES_GPU_DIR}\" for storing results already exists!"
    fi
  fi

  echo " "
  echo "${info}: Device(s) to be tested: "
  if [ "${TEST_GPU}" == "Y" ]; then
    if [ "${TEST_CUDA}" == "Y" ]; then
      echo "\"${LABEL_GPU}\" GPU (CUDA)"
    elif [ "${TEST_OPENCL}" == "Y" ]; then
      echo "\"${LABEL_GPU}\" GPU (OpenCL)"
    elif [ "${TEST_DPCPP}" == "Y" ]; then
      echo "\"${LABEL_GPU}\" GPU (DPC++)"
    fi
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
    if [ "${TEST_CUDA}" == "Y" ]; then
      for i_adgpu_bin in ${ADGPU_CUDA_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          echo "${info}: \"${i_adgpu_bin}\" exists."
        else
          echo "${info}: \"${i_adgpu_bin}\" does not exist. Make sure CUDA binary is copied over first!"
          echo "${info}: Terminated."
          exit 9999 # Die with error code 9999
        fi
      done
    elif [ "${TEST_OPENCL}" == "Y" ]; then
      for i_adgpu_bin in ${ADGPU_OPENCL_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          echo "${info}: \"${i_adgpu_bin}\" exists."
        else
          echo "${info}: \"${i_adgpu_bin}\" does not exist. Make sure OpenCL binary is copied over first!"
          echo "${info}: Terminated."
          exit 9999 # Die with error code 9999
        fi
      done
    elif [ "${TEST_DPCPP}" == "Y" ]; then
      for i_adgpu_bin in ${ADGPU_DPCPP_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          echo "${info}: \"${i_adgpu_bin}\" exists."
        else
          echo "${info}: \"${i_adgpu_bin}\" does not exist. Make sure DPC++ binary is copied over first!"
          echo "${info}: Terminated."
          exit 9999 # Die with error code 9999
        fi
      done
    fi
  fi
}
