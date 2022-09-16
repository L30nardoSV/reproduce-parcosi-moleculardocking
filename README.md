# Experiments AD-GPU DPCPP

This repository contains instructions and corresponding scripts for performing experiments.

## Instructions

### 1. Program preparation

Clone _this_ experiments repository:

```
git clone https://github.com/LeoCollab/experiments-adgpu-dpcpp.git
```

Clone the AutoDock-GPU code repository, which contains DPCPP as well as CUDA and OpenCL versions:

```
git clone https://github.com/emascarenhas/AutoDock-GPU.git
cd AutoDock-GPU
```

### 2. Program compilation

#### 2.1. Compile DPCPP version

Set the required oneAPI environment variables by executing initialization script (**NOT** required on DevCloud):

```
source /opt/intel/oneapi/setvars.sh
```

Compile DPCPP code, and move generated binaries into the experiments folder:

```
make DEVICE=XeGPU NUMWI=32 && cp bin/autodock_xegpu_32wi ../experiments-adgpu-dpcpp/
make DEVICE=XeGPU NUMWI=64 && cp bin/autodock_xegpu_64wi ../experiments-adgpu-dpcpp/
make DEVICE=XeGPU NUMWI=128 && cp bin/autodock_xegpu_128wi ../experiments-adgpu-dpcpp/
make DEVICE=XeGPU NUMWI=256 && cp bin/autodock_xegpu_256wi ../experiments-adgpu-dpcpp/
```

#### 2.2. Compile CUDA and OpenCL versions

Move back to folder containing code repository:

```
cd ../AutoDock-GPU
```

Switch to original git branch holding equivalent CUDA and OpenCL versions (DPCPP code was translated from this CUDA code):

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
make DEVICE=GPU NUMWI=32 && mv bin/autodock_gpu_32wi bin/autodock_gpu_32wi_cuda
make DEVICE=GPU NUMWI=64 && mv bin/autodock_gpu_64wi bin/autodock_gpu_64wi_cuda
make DEVICE=GPU NUMWI=128 && mv bin/autodock_gpu_128wi bin/autodock_gpu_128wi_cuda
make DEVICE=GPU NUMWI=256 && mv bin/autodock_gpu_256wi bin/autodock_gpu_256wi_cuda
```

```
make DEVICE=OCLGPU NUMWI=32 && mv bin/autodock_gpu_32wi bin/autodock_gpu_32wi_ocl
make DEVICE=OCLGPU NUMWI=64 && mv bin/autodock_gpu_64wi bin/autodock_gpu_64wi_ocl
make DEVICE=OCLGPU NUMWI=128 && mv bin/autodock_gpu_128wi bin/autodock_gpu_128wi_ocl
make DEVICE=OCLGPU NUMWI=256 && mv bin/autodock_gpu_256wi bin/autodock_gpu_256wi_ocl
```

Move above binaries into the experiments folder:

```
cp bin/autodock_gpu_32wi_cuda ../experiments-adgpu-dpcpp/
cp bin/autodock_gpu_64wi_cuda ../experiments-adgpu-dpcpp/
cp bin/autodock_gpu_128wi_cuda ../experiments-adgpu-dpcpp/
cp bin/autodock_gpu_256wi_cuda ../experiments-adgpu-dpcpp/
```

```
cp bin/autodock_gpu_32wi_ocl ../experiments-adgpu-dpcpp/
cp bin/autodock_gpu_64wi_ocl ../experiments-adgpu-dpcpp/
cp bin/autodock_gpu_128wi_ocl ../experiments-adgpu-dpcpp/
cp bin/autodock_gpu_256wi_ocl ../experiments-adgpu-dpcpp/
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
