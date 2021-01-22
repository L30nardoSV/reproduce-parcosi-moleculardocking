#!/bin/bash

# NUMWI Experiments on TitanV
# Use commit: eed190fd
# Make sure "results" folder exists

# NUMWI set
NUMWI_SET=(16 32 64 128 256)

# PARCOSI dataset
#PARCOSI_DATASET=(1u4d 1xoz 1yv3 1owe 1oyt 1ywr 1t46 2bm2 1mzc 1r55 5wlo 1kzk 3s8o 5kao 1hfs 1jyq 2d1o 3drf 4er4 3er5)
PARCOSI_DATASET=(1u4d 1yv3)

# LSMET set
LSMET_SET=(sw ad)

# Execution parameters
LSIT=300
LSRAT=100.000000
SMOOTH=0.500
NEV=2048000
NGEN=99999
NRUN=100
PSIZE=150
EVAL_INPUTS_DIR=../../data

# Cloning 
git clone https://github.com/ccsb-scripps/AutoDock-GPU.git
cd AutoDock-GPU

# Compiling binaries
make clean
make DEVICE=OCLGPU NUMWI=16
make DEVICE=OCLGPU NUMWI=32
make DEVICE=OCLGPU NUMWI=64
make DEVICE=OCLGPU NUMWI=128
make DEVICE=OCLGPU NUMWI=256
RESULTS_DIR="results_v100_numwi"
mkdir -p ${RESULTS_DIR}

# SW
for inumwi in ${NUMWI_SET[@]}; do
    echo " "
    for ipdb in ${PARCOSI_DATASET[@]}; do    
        echo " "
        for ilsmet in ${LSMET_SET[@]}; do    
            echo " "
            ./bin/autodock_gpu_${inumwi}wi \
            -lsmet ${ilsmet} \
            -lsit ${LSIT} -lsrat ${LSRAT} -smooth ${SMOOTH} \
            -nev ${NEV} -ngen ${NGEN} -nrun ${NRUN} -psize ${PSIZE} \
            -lfile ${EVAL_INPUTS_DIR}/${ipdb}/rand-0.pdbqt \
            -xraylfile ${EVAL_INPUTS_DIR}/${ipdb}/flex-xray.pdbqt \
            -ffile ${EVAL_INPUTS_DIR}/${ipdb}/protein.maps.fld \
            -xmloutput 0 \
            -resnam ${RESULTS_DIR}/v100_nwi-${inumwi}_pdb-${ipdb}_${ilsmet}_"`date +"%Y-%m-%d-%H:%M"`"
        done
    done
done