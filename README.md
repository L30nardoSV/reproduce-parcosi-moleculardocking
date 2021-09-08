# Reproducing PARCOSI: _Title_

This repository contains the scripts and additional files for reproducing the results presented in the paper:

_"Title"_ 

submitted to 

PARCOSI (under revision).

## Instructions

### 1. Input preparation

Input dataset is provided as a git submodule. 

To automatically clone [that repository](https://gitlab.com/L30nardoSV/ad-gpu_miniset_20.git): `./prepare_inputs.sh`

### 2. Performance evaluation

* Varying the OpenCL work group size:  `./evaluate_numwi.sh`
* The _autostop_ option: `./evaluate_autostop.sh`
* The _heuristic_ option `./evaluate_heuristics.sh`
* Combination of both _autostop_ and _heuristic_ options: `./evaluate_auto_plus_heur.sh`

