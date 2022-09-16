#!/bin/bash

# Bash functions
function select_device() {
  printf '\n%s\n' "[FUNCTION] Selecting device to test with AutoDock-GPU."

  printf '\n%s\n' "GPU?"
  read -p "[Y]: " TEST_GPU
  if [ "${TEST_GPU}" != "Y" ]; then
    printf '%s\n' " -> No device chosen -> Terminated" && exit 9999
  fi

  DEVNUM=${DEVNUM: 1}
  printf '\n%s\n' "DEVNUM? (starts at 1, choose preferably 1)"
  read -p "[1] or [2] or [3] or [...]: " DEVNUM
  case $DEVNUM in
    (*[^0-9]*)
		printf '%s\n' " -> Not a number -> Terminated" && exit 9999;;
    ("")
		printf '%s\n' " -> Empty -> Terminated" && exit 9999;;
    (*)
		printf '%s\n' " -> OK. It is a number";;
  esac

  printf '\n%s\n' "Select a code version."
  read -p "CUDA [c], OpenCL [o], or DPCPP [d]: " TEST_VERSION
  if [ "${TEST_VERSION}" == "c" ]; then
	printf '%s\n' " -> CUDA version will be executed"
  elif [ "${TEST_VERSION}" == "o" ]; then
	printf '%s\n' " -> OpenCL version will be executed"
  elif [ "${TEST_VERSION}" == "d" ]; then
	printf '%s\n' " -> DPC++ version will be executed"
  else
	printf '%s\n' " -> Wrong code version -> Terminated" && exit 9999
  fi

  printf '\n%s\n' "Type a meaningful label for your GPU device."
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
    printf '%s\n' " -> \"${RES_GPU_DIR}\" folder will store results"
    printf '%s\n' " -> \"${RES_GPU_DIR}.log\" file will contain stderr and stdout logs"
  else
    printf '%s\n' " -> \"${RES_GPU_DIR}\" folder already exists. Be cautios!"
  fi
}

function verify_binaries_exist_in_local_folder() {
  printf '\n%s\n' "[FUNCTION] Verifying that AutoDock-GPU binaries are present in current folder."

  if [ "${TEST_GPU}" == "Y" ]; then
    if [ "${TEST_VERSION}" == "c" ]; then
      for i_adgpu_bin in ${ADGPU_CUDA_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          printf '\n%s\n' "\"${i_adgpu_bin}\" exists."
        else
          printf '%s\n' " -> Make sure CUDA binary is copied over first"
          printf '%s\n' " -> \"${i_adgpu_bin}\" does not exist -> Terminated." && exit 9999
        fi
      done
    elif [ "${TEST_VERSION}" == "o" ]; then
      for i_adgpu_bin in ${ADGPU_OPENCL_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          printf '\n%s\n' "\"${i_adgpu_bin}\" exists."
        else
          printf '%s\n' " -> Make sure OpenCL binary is copied over first"
          printf '%s\n' " -> \"${i_adgpu_bin}\" does not exist -> Terminated." && exit 9999
        fi
      done
    elif [ "${TEST_VERSION}" == "d" ]; then
      for i_adgpu_bin in ${ADGPU_DPCPP_BINS[@]}; do
        if [ -f "${i_adgpu_bin}" ]; then
          printf '\n%s\n' "\"${i_adgpu_bin}\" exists."
        else
          printf '%s\n' " -> Make sure DPC++ binary is copied over first"
          printf '%s\n' " -> \"${i_adgpu_bin}\" does not exist -> Terminated." && exit 9999
        fi
      done
    fi
  fi
}
