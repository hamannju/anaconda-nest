#!/bin/bash

# Set environment name
ENV_NAME="nest-mpi"

# Remove existing nest-simulator directory if it exists
rm -rf nest-simulator-2.20.2

# Download NEST Simulator release 2.20.2
wget https://github.com/nest/nest-simulator/archive/refs/tags/v2.20.2.tar.gz
tar -xzf v2.20.2.tar.gz
cd nest-simulator-2.20.2

# Remove the downloaded tarball
rm ../v2.20.2.tar.gz

# Fix the version string in NestVersionInfo.cmake
sed -i 's/set(NEST_VERSION_BRANCH "nest-2.20.2")/set(NEST_VERSION_BRANCH "2.20.2")\n    set(NEST_VERSION "${NEST_VERSION_BRANCH}")/' cmake/NestVersionInfo.cmake

# Remove existing build directory if it exists
rm -rf build

# Create a new build directory
mkdir build
cd build

# Use conda run to execute commands in the specified environment
conda run -n $ENV_NAME bash -c '
    # Ensure compilers are available
    which gcc
    which g++
    
    # Configure NEST
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$CONDA_PREFIX \
          -DCMAKE_C_COMPILER=$(which gcc) \
          -Dwith-mpi=ON \
          -Dwith-python=3 \
          -Wno-dev \
          -DCMAKE_CXX_COMPILER=$(which g++) ..

    # Compile and install NEST
    make
    make install
    #make installcheck

    # Check if nest_vars.sh exists before sourcing
    if [ -f "$CONDA_PREFIX/bin/nest_vars.sh" ]; then
        source $CONDA_PREFIX/bin/nest_vars.sh
        echo "NEST environment variables set."
    else
        echo "Warning: nest_vars.sh not found. NEST environment variables not set."
    fi

    echo "NEST Simulator has been built and installed in the $ENV_NAME environment."
'