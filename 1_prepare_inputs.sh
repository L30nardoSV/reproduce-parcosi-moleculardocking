#!/bin/bash

# Source: https://gitlab.com/L30nardoSV/ad-gpu_miniset_20.git

# Pulling set of 20 inputs
(	# Starting a subshell to print only the command
	set -x; \
	git submodule update --init --recursive
)
