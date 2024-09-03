#!/bin/bash

# Download NEST Simulator release 2.20.2
wget https://github.com/nest/nest-simulator/archive/refs/tags/v2.20.2.tar.gz
tar -xzf v2.20.2.tar.gz

# Remove the downloaded tarball
rm v2.20.2.tar.gz