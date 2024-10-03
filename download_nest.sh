#!/bin/bash
NEST_VERSION=3.8

rm -rf nest-simulator-$NEST_VERSION

# Download NEST Simulator release 2.20.2
wget https://github.com/nest/nest-simulator/archive/refs/tags/v$NEST_VERSION.tar.gz
tar -xzf v$NEST_VERSION.tar.gz

# Remove the downloaded tarball
rm v$NEST_VERSION.tar.gz
