#!/bin/bash

source common_params.sh

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
            -resnam $2/$1_${ipdb}_${ilsmet}_"`date +"%Y-%m-%d-%H:%M"`"
        done
    done
}
