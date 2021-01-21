# Script that prepares molecular inputs.
# Automatically pulls git submodule first.
# This should be run at the very beginning.

#!/bin/bash

set -o xtrace

# Pulling dataset
# Source: https://github.com/L30nardoSV/AD-GPU_miniset_20
git submodule update --init --recursive

# Preparing dataset as some subfiles were compressed
EVAL_INPUTS_DIR=./AD-GPU_miniset_20/data

for dir in ${EVAL_INPUTS_DIR}/*; do
    if [ -d "${dir}" ]; then
        echo "${dir}"
        cd ${dir} && gunzip protein.*.map.gz
        cd ../../..
    fi
done
