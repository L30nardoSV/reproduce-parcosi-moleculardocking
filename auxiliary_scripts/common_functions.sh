#!/bin/bash

# Bash functions
function select_device() {
  echo " "
  echo "[FUNCTION] Selecting device to test with AutoDock-GPU."
  echo " "
  echo "GPU? "
  read -p "[Y]: " TEST_GPU
  if [ "${TEST_GPU}" != "Y" ]; then
    echo "No device chosen."
    echo "Terminated."
    exit 9999 # Die with error code 9999
  fi

  DEVNUM=${DEVNUM: 1}
  echo " "
  echo "DEVNUM? (starts at 1, choose preferably 1)"
  read -p "[1] or [2] or [3] or [...]: " DEVNUM
  case $DEVNUM in
    (*[^0-9]*)
		printf '%s\n' "Not a number"
		echo "Terminated."
		exit 9999;;
    ("")
		printf '%s\n' "Empty"
		echo "Terminated."
		exit 9999;;
    (*)
		printf '%s\n' "OK. It is a number";;
  esac

  echo " "
  echo "Select a code version."
  read -p "CUDA [c], OpenCL [o], or DPCPP [d]: " TEST_VERSION
  if [ "${TEST_VERSION}" == "c" ]; then
	echo "CUDA version will be executed"
  elif [ "${TEST_VERSION}" == "o" ]; then
	echo "OpenCL version will be executed"
  elif [ "${TEST_VERSION}" == "d" ]; then
	echo "DPC++ version will be executed"
  else
    echo "Wrong code version. Type either [c], or [o], or [d]."
    echo "Terminated."
    exit 9999
  fi

  echo " "
  echo "Type a meaningful label for your GPU device."
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
    echo "Be cautious. Folder \"${RES_GPU_DIR}\" for storing results already exists!"
  fi

  echo " "
  echo "Device(s) to be tested: "
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
  echo "[FUNCTION] Verifying that AutoDock-GPU binaries are present in current folder."
  echo " "
  if [ "${TEST_GPU}" == "Y" ]; then
    if [ "${TEST_VERSION}" == "c" ]; then
      for i_adgpu_bin in ${ADGPU_CUDA_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          echo "\"${i_adgpu_bin}\" exists."
        else
          echo "\"${i_adgpu_bin}\" does not exist. Make sure CUDA binary is copied over first!"
          echo "Terminated."
          exit 9999
        fi
      done
    elif [ "${TEST_VERSION}" == "o" ]; then
      for i_adgpu_bin in ${ADGPU_OPENCL_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          echo "\"${i_adgpu_bin}\" exists."
        else
          echo "\"${i_adgpu_bin}\" does not exist. Make sure OpenCL binary is copied over first!"
          echo "Terminated."
          exit 9999
        fi
      done
    elif [ "${TEST_VERSION}" == "d" ]; then
      for i_adgpu_bin in ${ADGPU_DPCPP_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          echo "\"${i_adgpu_bin}\" exists."
        else
          echo "\"${i_adgpu_bin}\" does not exist. Make sure DPC++ binary is copied over first!"
          echo "Terminated."
          exit 9999
        fi
      done
    fi
  fi
}
