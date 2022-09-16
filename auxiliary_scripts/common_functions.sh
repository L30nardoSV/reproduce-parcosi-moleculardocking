#!/bin/bash

# Bash functions
function select_device() {
  echo " "
  echo "${info}: Selecting device to test with AutoDock-GPU."
  echo " "
  echo "${info}: GPU? "
  read -p "[Y]: " TEST_GPU
  if [ "${TEST_GPU}" != "Y" ]; then
    echo "${info}: No device chosen."
    echo "${info}: Terminated."
    exit 9999 # Die with error code 9999
  fi

  DEVNUM=${DEVNUM: 1}
  echo " "
  echo "${info}: DEVNUM? (starts at 1)"
  read -p "[<1> or <2> or <3> or etc]: " DEVNUM
  case $DEVNUM in
    (*[^0-9]*)
		printf '%s\n' "not a number"
		echo "${info}: Terminated."
		exit 9999;;
    ("")
		printf '%s\n' "empty"
		echo "${info}: Terminated."
		exit 9999;;
    (*)
		printf '%s\n' "a number";;
  esac

  echo " "
  echo "${info}: Select one code version."
  read -p "CUDA [c], OpenCL [o], or DPCPP [d]: " TEST_VERSION
  if [ "${TEST_VERSION}" == "c" ]; then
	echo " "
  elif [ "${TEST_VERSION}" == "o" ]; then
	echo " "
  elif [ "${TEST_VERSION}" == "d" ]; then
	echo " "
  else
    echo "${info}: Wrong input. Enter [c], [o], or [d]."
    echo "${info}: Terminated."
    exit 9999
  fi

  echo " "
  echo "${info}: Type a meaningful label for your GPU device."
  read -p "E.g.: [v100] [a100] [mi50] [mi100] [vega64] [etc]: " LABEL_GPU

  if [ "${TEST_VERSION}" == "c" ]; then
    RES_GPU_DIR=results_numwi_cuda_${LABEL_GPU}
  elif [ "${TEST_VERSION}" == "o" ]; then
    RES_GPU_DIR=results_numwi_opencl_${LABEL_GPU}
  elif [ "${TEST_VERSION}" == "d" ]; then
    RES_GPU_DIR=results_numwi_dpcpp_${LABEL_GPU}
  fi

  if [ ! -d ${RES_GPU_DIR} ]; then
    mkdir ${RES_GPU_DIR}
  else
    echo "${info}: Be cautious. Folder \"${RES_GPU_DIR}\" for storing results already exists!"
  fi

  echo " "
  echo "${info}: Device(s) to be tested: "
  if [ "${TEST_GPU}" == "Y" ]; then
    if [ "${TEST_VERSION}" == "c" ]; then
      echo "\"${LABEL_GPU}\" GPU (CUDA)"
    elif [ "${TEST_VERSION}" == "o" ]; then
      echo "\"${LABEL_GPU}\" GPU (OpenCL)"
    elif [ "${TEST_VERSION}" == "d" ]; then
      echo "\"${LABEL_GPU}\" GPU (DPC++)"
    fi
  fi
}

function verify_binaries_exist_in_local_folder() {
  echo " "
  echo "${info}: Verifying that AutoDock-GPU binaries are present in current folder."
  echo " "
  if [ "${TEST_GPU}" == "Y" ]; then
    if [ "${TEST_VERSION}" == "c" ]; then
      for i_adgpu_bin in ${ADGPU_CUDA_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          echo "${info}: \"${i_adgpu_bin}\" exists."
        else
          echo "${info}: \"${i_adgpu_bin}\" does not exist. Make sure CUDA binary is copied over first!"
          echo "${info}: Terminated."
          exit 9999
        fi
      done
    elif [ "${TEST_VERSION}" == "o" ]; then
      for i_adgpu_bin in ${ADGPU_OPENCL_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          echo "${info}: \"${i_adgpu_bin}\" exists."
        else
          echo "${info}: \"${i_adgpu_bin}\" does not exist. Make sure OpenCL binary is copied over first!"
          echo "${info}: Terminated."
          exit 9999
        fi
      done
    elif [ "${TEST_VERSION}" == "d" ]; then
      for i_adgpu_bin in ${ADGPU_DPCPP_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          echo "${info}: \"${i_adgpu_bin}\" exists."
        else
          echo "${info}: \"${i_adgpu_bin}\" does not exist. Make sure DPC++ binary is copied over first!"
          echo "${info}: Terminated."
          exit 9999
        fi
      done
    fi
  fi
}
