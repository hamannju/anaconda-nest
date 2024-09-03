#!/bin/bash

# Set the environment name
ENV_NAME="nest-mpi"

# Remove the existing environment if it exists
conda env remove --name $ENV_NAME --yes

# Create conda environment
conda env create -f environment.yml

# Activate conda environment
#conda activate $ENV_NAME

echo "Environment $ENV_NAME has been recreated and activated."
