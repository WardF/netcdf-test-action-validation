#!/bin/bash

CVER=v4.9.2
FVER=v4.6.1
H5VER=1.14.6


USECC=gcc
docker run --rm -it -e GITHUB_ACTIONS=TRUE -e CBRANCH=${CVER} -e FBRANCH=${FVER} -e H5VER=${H5VER} -e USE_CC=${USECC} -e USE_BUILDSYSTEM=both -v $(pwd)/environments:/environments docker.unidata.ucar.edu/nctests
 
USECC=mpicc
docker run --rm -it -e GITHUB_ACTIONS=TRUE -e CBRANCH=${CVER} -e FBRANCH=${FVER} -e H5VER=${H5VER} -e USE_CC=${USECC} -e USE_BUILDSYSTEM=both -v $(pwd)/environments:/environments docker.unidata.ucar.edu/nctests