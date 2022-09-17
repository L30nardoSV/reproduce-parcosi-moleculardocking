#!/bin/bash

AUXILIARY_SCRIPTS_DIR=auxiliary_scripts

source ${AUXILIARY_SCRIPTS_DIR}/common_params.sh

function numwi() {
	for ipdb in ${EXPERIMENTS_DATASET[@]}; do
		printf '%s\n' " "
		for ilsmet in ${LSMET_SET[@]}; do
			printf '%s\n' " "
			( # Starting a subshell to print only the command
				set -x; \
				$1 \
				-lsmet ${ilsmet} \
				-lsit ${LSIT} \
				-lsrat ${LSRAT} \
				-smooth ${SMOOTH} \
				-nev ${NEV} \
				-ngen ${NGEN} \
				-nrun ${NRUN} \
				-psize ${PSIZE} \
				-lfile ${INPUTS_DIR}/${ipdb}/rand-0.pdbqt \
				-xraylfile ${INPUTS_DIR}/${ipdb}/flex-xray.pdbqt \
				-ffile ${INPUTS_DIR}/${ipdb}/protein.maps.fld \
				-xmloutput 0 \
				-autostop ${EARLY_TERM_ARG} \
				-heuristics ${EARLY_TERM_ARG} \
				-resnam ${RES_GPU_DIR}/$1_${ipdb}_${ilsmet}_"`date +"%Y-%m-%d-%H:%M"`" \
				-devnum ${DEVNUM}
			)
		done
	done
}
