# Script that prepares molecular inputs.
# Automatically pulls git submodule first.
# This should be run at the very beginning.

#!/bin/bash

set -o xtrace

# Pulling dataset
# Source: https://github.com/L30nardoSV/AD-GPU_miniset_20
git submodule update --init --recursive
