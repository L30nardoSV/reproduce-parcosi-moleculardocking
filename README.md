# Experiments AD-GPU DPCPP

This repository contains the scripts and additional files for experiments.

## Instructions

### 1. Program preparation

Clone the repository including DPCPP as well as CUDA and OpenCL versions

```
git clone --depth 1 --branch develop https://github.com/ccsb-scripps/AutoDock-GPU.git
cd AutoDock-GPU
```

Clone _this_ repository:

```
git clone https://github.com/LeoCollab/experiments-adgpu-dpcpp.git
```

### 2. Program compilation

#### DPCPP version

Set environment variables by executing initialization script (not required on DevCloud):

```
source /opt/intel/oneapi/setvars.sh
```

Compile DPCPP code and rename the produced binaries conveniently (for the scripts to work):

```
make DEVICE=XeGPU NUMWI=256
... Do the same for NUMWI = {32, 64, 128, 256}
```

Move above binaries into the test folder:

```
cp bin/autodock_xegpu_64wi experiments-adgpu-dpcpp/
... Repeat for all DPCPP cases above
```

#### CUDA and OpenCL versions

Switch to original git branch holding equivalent CUDA and OpenCL versions (used as baseline):

```
git checkout v1.5.3
```

Set environment variables (adapt the paths to your systems' installation):

```
export GPU_INCLUDE_PATH=/usr/local/cuda/include
export GPU_LIBRARY_PATH=/usr/local/cuda/lib64
```

Compile CUDA and OpenCL codes and rename the produced binaries conveniently (for the scripts to work):

```
make DEVICE=GPU NUMWI=256
mv bin/autodock_gpu_256wi bin/autodock_gpu_256wi_cuda
... Do the same for NUMWI = {32, 64, 128, 256}
```

```
make DEVICE=OCLGPU NUMWI=32
mv bin/autodock_gpu_32wi bin/autodock_gpu_32wi_ocl
... Do the same for NUMWI = {32, 64, 128, 256}
```

Move above binaries into the test folder:

```
cp bin/autodock_gpu_64wi_ocl experiments-adgpu-dpcpp/
... Repeat for all OpenCL/CUDA cases above
```

### 3. Performance evaluation

Input dataset is provided as a git submodule. Clone [that repository](https://gitlab.com/L30nardoSV/ad-gpu_miniset_20.git) automatically: 

```
./prepare_inputs.sh
```

Evaluate the performance for different OpenCL work group sizes:  

```
./evaluate_numwi.sh
```

Evaluate the impact of combining of both _autostop_ and _heuristic_ options: 

```
./evaluate_auto_plus_heur.sh
```
