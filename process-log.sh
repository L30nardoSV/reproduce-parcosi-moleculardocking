#!/bin/bash

# invoke in the directory where log files are present as

#for i in *.log; do  <dir>/process-log.sh [<platform-descr>] < $i >> data.csv; done

if [ -z $1 ]; then

    plat="XeGPU"

else

    plat=$1

fi

# |Setup time|Docking|Shutdown|entire|Processing|Best energy|Offload time|Offload setup

 

#echo "Protein, Setup time, Docking, Shutdown, entire, Processing, Best energy, Offload time, Offload setup"

awk -v platform=$plat \

'/resnam/ {resnam=$NF; p = match(resnam, "pu_[0-9]");} \

/([^f]) Setup time / {xegpu_setup =  $4; gsub("s","",xegpu_setup)} \

/Rest of/ {rest_of = $5; gsub("s","",rest_of)} \

/Docking/ {docking = $3; gsub("s", "", docking)} \

/Shutdown/ {shutdown = $3; gsub("s", "", shutdown)} \

/entire/ {entire = $9} \

/after waiting/ {offload_time = $4; offload_setup_time = $8} \

/Processing/ {processing = $3} \

/[Bb]est energy/ {energy = $5} \

END {print substr(resnam, p+8, 4), ", ", platform, ", ", xegpu_setup, ",", rest_of, ",", docking, ",",\

shutdown, ",", processing, ",", entire, ",", energy, ",", offload_time, ",", offload_setup_time;}'
