#!/bin/bash

# Set environment name
ENV_NAME="nest-mpi"

# Check if the download was successful
if [ ! -d "nest-simulator-2.20.2" ]; then
    echo "Error: NEST Simulator not found. Exiting."
    exit 1
fi

# Overwrite the CMakeLists.txt file in the pynest directory to copy .py and .sli files directly to site-packages/nest
cp CMakeLists.txt nest-simulator-2.20.2/pynest/CMakeLists.txt

# Overwrite the CMakeLists.txt in the topology directory to install files to site-packages/nest/topology
cp CMakeListsTopology.txt nest-simulator-2.20.2/topology/CMakeLists.txt

# Overwrite the NestVersionInfo.cmake file in the cmake directory to set NEST_VERSION_BRANCH to 2.20.2 instead of noncompliant nest-2.20.2
cp NestVersionInfo.cmake nest-simulator-2.20.2/cmake/NestVersionInfo.cmake

# Switch to the nest-simulator-2.20.2 directory
cd nest-simulator-2.20.2

# Use conda run to execute commands in the specified environment
conda run --live-stream -n $ENV_NAME bash -c '
    which gcc
    which g++
    
    # Configure NEST
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$CONDA_PREFIX \
          -DCMAKE_C_COMPILER=$(which gcc) \
          -Dwith-mpi=ON \
          -Dwith-python=3 \
          -Dwith-boost=ON \
          -Wno-dev \
          -Wunused-variable \
          -Dwith-optimize="-O3 -march=native" \
          -DCMAKE_CXX_COMPILER=$(which g++) .

    # Compile and install NEST
    make
    make install

    # Run nest -h to generate ~/.nestrc for MPI operations
    nest -h

    # Run test suite
    make installcheck

    # source $CONDA_PREFIX/bin/nest_vars.sh
    # echo "NEST environment variables set."

    echo "NEST Simulator has been built and installed in the $ENV_NAME environment."
'