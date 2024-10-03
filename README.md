# Nest 3.8 for Imperial HPC Cluster with OpenMPI 5
## Description
This repository contains a modified version of the NEST simulator, adapted for use on the Imperial HPC cluster with OpenMPI 5. The modifications include updates to the CMake configuration to fix build errors and ensure compatibility with the cluster's environment.

## Installation
Run the following script:
1. ./main.sh

This will first create a conda environment called "nest3-mpi" and then download, compile, and install NEST within that environment. The enviroment is configured by the environent.yml file. Nest is downloaded from the offical github repository and some modifications are made to ensure the installation works correctly in the new conda environment.

The scripts can be re-run in the same order to recreate the environment from scratch.