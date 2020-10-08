#!/bin/bash

# NUMWI Experiments on Vega64
# Use commit: eed190fd
# Make sure "results" folder exists

#SW:

##16wi:
./bin/autodock_gpu_16wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/1u4d/rand-0.pdbqt -xraylfile data/1u4d/flex-xray.pdbqt -ffile data/1u4d/protein.maps.fld -smooth 0.500 -resnam results/1u4d_vega64_autodock_gpu_16wi_sw_rand-0
./bin/autodock_gpu_16wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/3s8o/rand-0.pdbqt -xraylfile data/3s8o/flex-xray.pdbqt -ffile data/3s8o/protein.maps.fld -smooth 0.500 -resnam results/3s8o_vega64_autodock_gpu_16wi_sw_rand-0
./bin/autodock_gpu_16wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/3er5/rand-0.pdbqt -xraylfile data/3er5/flex-xray.pdbqt -ffile data/3er5/protein.maps.fld -smooth 0.500 -resnam results/3er5_vega64_autodock_gpu_16wi_sw_rand-0

##32wi:
./bin/autodock_gpu_32wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/1u4d/rand-0.pdbqt -xraylfile data/1u4d/flex-xray.pdbqt -ffile data/1u4d/protein.maps.fld -smooth 0.500 -resnam results/1u4d_vega64_autodock_gpu_32wi_sw_rand-0
./bin/autodock_gpu_32wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/3s8o/rand-0.pdbqt -xraylfile data/3s8o/flex-xray.pdbqt -ffile data/3s8o/protein.maps.fld -smooth 0.500 -resnam results/3s8o_vega64_autodock_gpu_32wi_sw_rand-0
./bin/autodock_gpu_32wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/3er5/rand-0.pdbqt -xraylfile data/3er5/flex-xray.pdbqt -ffile data/3er5/protein.maps.fld -smooth 0.500 -resnam results/3er5_vega64_autodock_gpu_32wi_sw_rand-0

##64wi:
./bin/autodock_gpu_64wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/1u4d/rand-0.pdbqt -xraylfile data/1u4d/flex-xray.pdbqt -ffile data/1u4d/protein.maps.fld -smooth 0.500 -resnam results/1u4d_vega64_autodock_gpu_64wi_sw_rand-0
./bin/autodock_gpu_64wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/3s8o/rand-0.pdbqt -xraylfile data/3s8o/flex-xray.pdbqt -ffile data/3s8o/protein.maps.fld -smooth 0.500 -resnam results/3s8o_vega64_autodock_gpu_64wi_sw_rand-0
./bin/autodock_gpu_64wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/3er5/rand-0.pdbqt -xraylfile data/3er5/flex-xray.pdbqt -ffile data/3er5/protein.maps.fld -smooth 0.500 -resnam results/3er5_vega64_autodock_gpu_64wi_sw_rand-0

##128wi:
./bin/autodock_gpu_128wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/1u4d/rand-0.pdbqt -xraylfile data/1u4d/flex-xray.pdbqt -ffile data/1u4d/protein.maps.fld -smooth 0.500 -resnam results/1u4d_vega64_autodock_gpu_128wi_sw_rand-0
./bin/autodock_gpu_128wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/3s8o/rand-0.pdbqt -xraylfile data/3s8o/flex-xray.pdbqt -ffile data/3s8o/protein.maps.fld -smooth 0.500 -resnam results/3s8o_vega64_autodock_gpu_128wi_sw_rand-0
./bin/autodock_gpu_128wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/3er5/rand-0.pdbqt -xraylfile data/3er5/flex-xray.pdbqt -ffile data/3er5/protein.maps.fld -smooth 0.500 -resnam results/3er5_vega64_autodock_gpu_128wi_sw_rand-0

##256wi:
./bin/autodock_gpu_256wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/1u4d/rand-0.pdbqt -xraylfile data/1u4d/flex-xray.pdbqt -ffile data/1u4d/protein.maps.fld -smooth 0.500 -resnam results/1u4d_vega64_autodock_gpu_256wi_sw_rand-0
./bin/autodock_gpu_256wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/3s8o/rand-0.pdbqt -xraylfile data/3s8o/flex-xray.pdbqt -ffile data/3s8o/protein.maps.fld -smooth 0.500 -resnam results/3s8o_vega64_autodock_gpu_256wi_sw_rand-0
./bin/autodock_gpu_256wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet sw -lfile data/3er5/rand-0.pdbqt -xraylfile data/3er5/flex-xray.pdbqt -ffile data/3er5/protein.maps.fld -smooth 0.500 -resnam results/3er5_vega64_autodock_gpu_256wi_sw_rand-0

#AD:

##16wi:
./bin/autodock_gpu_16wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/1u4d/rand-0.pdbqt -xraylfile data/1u4d/flex-xray.pdbqt -ffile data/1u4d/protein.maps.fld -smooth 0.500 -resnam results/1u4d_vega64_autodock_gpu_16wi_ad_rand-0
./bin/autodock_gpu_16wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/3s8o/rand-0.pdbqt -xraylfile data/3s8o/flex-xray.pdbqt -ffile data/3s8o/protein.maps.fld -smooth 0.500 -resnam results/3s8o_vega64_autodock_gpu_16wi_ad_rand-0
./bin/autodock_gpu_16wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/3er5/rand-0.pdbqt -xraylfile data/3er5/flex-xray.pdbqt -ffile data/3er5/protein.maps.fld -smooth 0.500 -resnam results/3er5_vega64_autodock_gpu_16wi_ad_rand-0

##32wi:
./bin/autodock_gpu_32wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/1u4d/rand-0.pdbqt -xraylfile data/1u4d/flex-xray.pdbqt -ffile data/1u4d/protein.maps.fld -smooth 0.500 -resnam results/1u4d_vega64_autodock_gpu_32wi_ad_rand-0
./bin/autodock_gpu_32wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/3s8o/rand-0.pdbqt -xraylfile data/3s8o/flex-xray.pdbqt -ffile data/3s8o/protein.maps.fld -smooth 0.500 -resnam results/3s8o_vega64_autodock_gpu_32wi_ad_rand-0
./bin/autodock_gpu_32wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/3er5/rand-0.pdbqt -xraylfile data/3er5/flex-xray.pdbqt -ffile data/3er5/protein.maps.fld -smooth 0.500 -resnam results/3er5_vega64_autodock_gpu_32wi_ad_rand-0

##64wi:
./bin/autodock_gpu_64wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/1u4d/rand-0.pdbqt -xraylfile data/1u4d/flex-xray.pdbqt -ffile data/1u4d/protein.maps.fld -smooth 0.500 -resnam results/1u4d_vega64_autodock_gpu_64wi_ad_rand-0
./bin/autodock_gpu_64wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/3s8o/rand-0.pdbqt -xraylfile data/3s8o/flex-xray.pdbqt -ffile data/3s8o/protein.maps.fld -smooth 0.500 -resnam results/3s8o_vega64_autodock_gpu_64wi_ad_rand-0
./bin/autodock_gpu_64wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/3er5/rand-0.pdbqt -xraylfile data/3er5/flex-xray.pdbqt -ffile data/3er5/protein.maps.fld -smooth 0.500 -resnam results/3er5_vega64_autodock_gpu_64wi_ad_rand-0

##128wi:
./bin/autodock_gpu_128wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/1u4d/rand-0.pdbqt -xraylfile data/1u4d/flex-xray.pdbqt -ffile data/1u4d/protein.maps.fld -smooth 0.500 -resnam results/1u4d_vega64_autodock_gpu_128wi_ad_rand-0
./bin/autodock_gpu_128wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/3s8o/rand-0.pdbqt -xraylfile data/3s8o/flex-xray.pdbqt -ffile data/3s8o/protein.maps.fld -smooth 0.500 -resnam results/3s8o_vega64_autodock_gpu_128wi_ad_rand-0
./bin/autodock_gpu_128wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/3er5/rand-0.pdbqt -xraylfile data/3er5/flex-xray.pdbqt -ffile data/3er5/protein.maps.fld -smooth 0.500 -resnam results/3er5_vega64_autodock_gpu_128wi_ad_rand-0

##256wi:
./bin/autodock_gpu_256wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/1u4d/rand-0.pdbqt -xraylfile data/1u4d/flex-xray.pdbqt -ffile data/1u4d/protein.maps.fld -smooth 0.500 -resnam results/1u4d_vega64_autodock_gpu_256wi_ad_rand-0
./bin/autodock_gpu_256wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/3s8o/rand-0.pdbqt -xraylfile data/3s8o/flex-xray.pdbqt -ffile data/3s8o/protein.maps.fld -smooth 0.500 -resnam results/3s8o_vega64_autodock_gpu_256wi_ad_rand-0
./bin/autodock_gpu_256wi -nev 2048000 -ngen 99999 -lsit 300 -lsrat 100.000000 -nrun 100 -lsmet ad -lfile data/3er5/rand-0.pdbqt -xraylfile data/3er5/flex-xray.pdbqt -ffile data/3er5/protein.maps.fld -smooth 0.500 -resnam results/3er5_vega64_autodock_gpu_256wi_ad_rand-0
