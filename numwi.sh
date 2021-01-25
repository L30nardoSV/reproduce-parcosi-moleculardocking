#!/bin/bash

set -o xtrace

# LSMET set
LSMET_SET=(sw ad)

# Execution parameters
LSIT=300
LSRAT=100.000000
SMOOTH=0.500
NEV=2500000
NGEN=99999
NRUN=100
PSIZE=150
INPUTS_DIR=./AD-GPU_miniset_20/data

function numwi() {
    for ipdb in ${PARCOSI_DATASET[@]}; do    
        echo " "
        for ilsmet in ${LSMET_SET[@]}; do    
            echo " "
            $1 \
            -lsmet ${ilsmet} \
            -lsit ${LSIT} -lsrat ${LSRAT} -smooth ${SMOOTH} \
            -nev ${NEV} -ngen ${NGEN} -nrun ${NRUN} -psize ${PSIZE} \
            -lfile ${INPUTS_DIR}/${ipdb}/rand-0.pdbqt \
            -xraylfile ${INPUTS_DIR}/${ipdb}/flex-xray.pdbqt \
            -ffile ${INPUTS_DIR}/${ipdb}/protein.maps.fld \
            -xmloutput 0 \
            -resnam $2/v100_nwi-${inumwi}_pdb-${ipdb}_${ilsmet}_"`date +"%Y-%m-%d-%H:%M"`"
        done
    done
}
