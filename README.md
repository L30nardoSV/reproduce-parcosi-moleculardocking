# Experiments AD-GPU DPCPP

This repository contains instructions and corresponding scripts for performing experiments.

## Instructions

### 1. Preparation

Clone _this_ experiments repository:

```
git clone https://github.com/LeoCollab/experiments-adgpu-dpcpp.git
```

Clone the AutoDock-GPU code repository, which contains DPCPP as well as CUDA and OpenCL versions:

```
git clone https://github.com/emascarenhas/AutoDock-GPU.git
```

### 2. Compilation

Move into the code folder:

```
cd AutoDock-GPU
```

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

Switch to git branch holding original CUDA and OpenCL versions (DPCPP code was translated from this equivalent CUDA code):

```
git checkout v1.5.3
```

Set environment variables (adapt the paths to your systems' installation):

```
export GPU_INCLUDE_PATH=/usr/local/cuda/include
export GPU_LIBRARY_PATH=/usr/local/cuda/lib64
```

Compile CUDA and OpenCL codes, rename the produced binaries conveniently (for the experiment scripts to work), and move generated binaries into the experiments folder:

```
make DEVICE=GPU NUMWI=32 && mv bin/autodock_gpu_32wi bin/autodock_gpu_32wi_cuda && cp bin/autodock_gpu_32wi_cuda ../experiments-adgpu-dpcpp/
make DEVICE=GPU NUMWI=64 && mv bin/autodock_gpu_64wi bin/autodock_gpu_64wi_cuda && cp bin/autodock_gpu_64wi_cuda ../experiments-adgpu-dpcpp/
make DEVICE=GPU NUMWI=128 && mv bin/autodock_gpu_128wi bin/autodock_gpu_128wi_cuda && cp bin/autodock_gpu_128wi_cuda ../experiments-adgpu-dpcpp/
make DEVICE=GPU NUMWI=256 && mv bin/autodock_gpu_256wi bin/autodock_gpu_256wi_cuda && cp bin/autodock_gpu_256wi_cuda ../experiments-adgpu-dpcpp/
```

```
make DEVICE=OCLGPU NUMWI=32 && mv bin/autodock_gpu_32wi bin/autodock_gpu_32wi_ocl && cp bin/autodock_gpu_32wi_ocl ../experiments-adgpu-dpcpp/
make DEVICE=OCLGPU NUMWI=64 && mv bin/autodock_gpu_64wi bin/autodock_gpu_64wi_ocl && cp bin/autodock_gpu_64wi_ocl ../experiments-adgpu-dpcpp/
make DEVICE=OCLGPU NUMWI=128 && mv bin/autodock_gpu_128wi bin/autodock_gpu_128wi_ocl && cp bin/autodock_gpu_128wi_ocl ../experiments-adgpu-dpcpp/
make DEVICE=OCLGPU NUMWI=256 && mv bin/autodock_gpu_256wi bin/autodock_gpu_256wi_ocl && cp bin/autodock_gpu_256wi_ocl ../experiments-adgpu-dpcpp/
```

_**Extra hints**_

Compilation of CUDA code for modern NVIDIA GPU architectures might require to also specify their compute capability. See [reference](https://github.com/ccsb-scripps/AutoDock-GPU/issues/172#issuecomment-1010263229).

For instance, when compiling for the A100 GPU, use instead:

```
make DEVICE=GPU NUMWI=32 TARGETS="80" && mv bin/autodock_gpu_32wi bin/autodock_gpu_32wi_cuda && cp bin/autodock_gpu_32wi_cuda ../experiments-adgpu-dpcpp/
make DEVICE=GPU NUMWI=64 TARGETS="80" && mv bin/autodock_gpu_64wi bin/autodock_gpu_64wi_cuda && cp bin/autodock_gpu_64wi_cuda ../experiments-adgpu-dpcpp/
make DEVICE=GPU NUMWI=128 TARGETS="80" && mv bin/autodock_gpu_128wi bin/autodock_gpu_128wi_cuda && cp bin/autodock_gpu_128wi_cuda ../experiments-adgpu-dpcpp/
make DEVICE=GPU NUMWI=256 TARGETS="80" && mv bin/autodock_gpu_256wi bin/autodock_gpu_256wi_cuda && cp bin/autodock_gpu_256wi_cuda ../experiments-adgpu-dpcpp/
```



### 3. Evaluation

Move into the experiments folder:

```
cd experiments-adgpu-dpcpp
```

Clone [git submodule repository containing input data-set](https://gitlab.com/L30nardoSV/ad-gpu_miniset_20.git) automatically: 

```
./1_prepare_inputs.sh
```

Evaluate the performance for different {DPCPP work-group} / {CUDA block} / {OpenCL work-group} sizes:

```
./2_evaluate_numwi.sh
```
