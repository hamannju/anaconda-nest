# Nest 2.20.2 for Imperial HPC Cluster with OpenMPI 4.1.6

## Description
This repository contains a modified version of the NEST simulator, adapted for use on the Imperial HPC cluster with OpenMPI 4.1.6. The modifications include updates to the CMake configuration to fix build errors and ensure compatibility with the cluster's environment.

## Installation
Run the scripts in the following order:

1. ./create_environment.sh
2. ./download_nest.sh
3. ./build_nest.sh

This will first create a conda environment called "nest-mpi" and then download, compile, and install NEST within that environment. The enviroment is configured by the environent.yml file. Nest is downloaded from the offical github repository and some modifications are made to ensure the installation works correctly in the new conda environment.

The scripts can be re-run in the same order to recreate the environment from scratch.

## Usage
After the installation run source ./activate_nest.sh to activate the environment. This is necessary to set the environment variables for the NEST simulator.