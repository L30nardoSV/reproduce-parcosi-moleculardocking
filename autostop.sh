#!/bin/bash

source common_params.sh

# ASFREQ set
# Autostop testing frequency (in # of generations)
ASFREQ_SET=(1 5 10 15 20 25)

function autostop() {
    for ipdb in ${PARCOSI_DATASET[@]}; do    
        echo " "
        for ilsmet in ${LSMET_SET[@]}; do    
            echo " "
            for iasfreq in ${ASFREQ_SET[@]}; do
                $1 \
                -lsmet ${ilsmet} \
                -lsit ${LSIT} -lsrat ${LSRAT} -smooth ${SMOOTH} \
                -nev ${NEV} -ngen ${NGEN} -nrun ${NRUN} -psize ${PSIZE} \
                -lfile ${INPUTS_DIR}/${ipdb}/rand-0.pdbqt \
                -xraylfile ${INPUTS_DIR}/${ipdb}/flex-xray.pdbqt \
                -ffile ${INPUTS_DIR}/${ipdb}/protein.maps.fld \
                -xmloutput 0 \
                -autostop 1 \
                -asfreq ${iasfreq} \
                -resnam $2/$1_${ipdb}_${ilsmet}_asf-${iasfreq}_"`date +"%Y-%m-%d-%H:%M"`" \
                -devnum ${DEVNUM}
            done
        done
    done
}
