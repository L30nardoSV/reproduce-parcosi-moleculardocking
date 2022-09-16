# Reproducing paper: _Benchmarking the Performance of Irregular Computations in AutoDock-GPU Molecular Docking_ 

This repository contains the scripts and additional files for reproducing the results presented in the paper accepted at Parallel Computing:

https://doi.org/10.1016/j.parco.2021.102861


## Instructions

### 1. Program preparation

Clone the [AutoDock-GPU v1.3](https://github.com/ccsb-scripps/AutoDock-GPU/releases/tag/v1.3) (used in this paper):

```
> git clone --depth 1 --branch v1.3 https://github.com/ccsb-scripps/AutoDock-GPU.git
> cd AutoDock-GPU
```

Set environmental variables (adapt the paths to your systems' installation):

```
> export GPU_INCLUDE_PATH=/usr/local/cuda/include
> export GPU_LIBRARY_PATH=/usr/local/cuda/lib64
```

Clone _this_ repository:

```
> git clone https://github.com/L30nardoSV/reproduce-parcosi-moleculardocking.git
```

Compile AutoDock-GPU and rename the produced binaries conveniently (for the scripts to work):

```
> make DEVICE=OCLGPU NUMWI=32
> mv bin/autodock_gpu_32wi bin/autodock_gpu_32wi_ocl
... Do the same for NUMWI = {32, 64, 128, 256}

> make DEVICE=GPU NUMWI=256
> mv bin/autodock_gpu_256wi bin/autodock_gpu_256wi_cuda
... Do the same for NUMWI = {32, 64, 128, 256}
```

Move above binaries into the test folder:

```
> cp bin/autodock_gpu_64wi_ocl reproduce-parcosi-moleculardocking/
... Repeat for all OpenCL/CUDA cases above
```

### 2. Performance evaluation

Input dataset is provided as a git submodule. Clone [that repository](https://gitlab.com/L30nardoSV/ad-gpu_miniset_20.git) automatically: 

```
> ./prepare_inputs.sh
```

Evaluate the performance for different OpenCL work group sizes:  

```
> ./evaluate_numwi.sh
```

Evaluate the impact of combining of both _autostop_ and _heuristic_ options: 

```
> ./evaluate_auto_plus_heur.sh
```
