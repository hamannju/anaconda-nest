#!/bin/bash

# Set the environment name
ENV_NAME="nest3-mpi"

# Remove the existing environment if it exists
conda remove -n $ENV_NAME --all --yes > /dev/null 2>&1

# Create conda environment
conda env create -f environment-v3.8.yaml
