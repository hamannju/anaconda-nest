#!/bin/bash

# Set the environment name
ENV_NAME="nest-mpi"

# Remove the existing environment if it exists
conda remove -n $ENV_NAME --all   --yes

# Create conda environment
conda env create -f environment.yml
