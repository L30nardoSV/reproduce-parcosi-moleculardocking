#!/bin/bash

set -o xtrace

# Pulling PARCOSI dataset
# Source: https://gitlab.com/L30nardoSV/ad-gpu_miniset_20.git
git submodule update --init --recursive
