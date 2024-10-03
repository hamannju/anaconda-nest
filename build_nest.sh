#!/bin/bash

# Set environment name
ENV_NAME="nest3-mpi"

# Check if the download was successful
if [ ! -d "nest-simulator-3.8" ]; then
    echo "Error: NEST Simulator not found. Exiting."
    exit 1
fi

# Switch to the nest-simulator-2.20.2 directory
cd nest-simulator-3.8

# Use conda run to execute commands in the specified environment
conda run --live-stream -n $ENV_NAME bash -c '
    which gcc
    which g++
    
    # Configure NEST
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$CONDA_PREFIX \
          -DCMAKE_C_COMPILER=$(which gcc) \
          -Dwith-mpi=ON \
          -Dwith-python=ON \
          -Dcythonize-pynest=ON \
          -Dwith-boost=ON \
          -Wno-dev \
          -Wunused-variable \
          -Wsign-compare \
          -Dwith-optimize="-O3 -march=native" \
          -Dwith-defines=-DNDEBUG \
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