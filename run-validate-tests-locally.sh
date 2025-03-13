#!/bin/bash

CVER=v4.9.2
FVER=v4.6.1
H5VER=1.14.6

echo "This will delete netcdf-c/ and netcdf-fortran/ if they exist !!!!!"
echo "ARE YOU SURE?"
echo ""
echo "Press [Return] to continue"
read

rm -rf netcdf-c netcdf-fortran
git clone git@github.com:Unidata/netcdf-c && cd netcdf-c && git checkout ${CVER} $$ cd ..
git clone git@github.com:Unidata/netcdf-fortran && cd netcdf-fortran && git checkout ${FVER} $$ cd ..

USECC=gcc
docker run --rm -it -e GITHUB_ACTIONS=TRUE -e CBRANCH=${CVER} -e FBRANCH=${FVER} -e H5VER=${H5VER} -e USE_CC=${USECC} -e USE_BUILDSYSTEM=both -v $(pwd)/environments:/environments -v $(pwd)/netcdf-c:/netcdf-c -v $(pwd)/netcdf-fortran:/netcdf-fortran docker.unidata.ucar.edu/nctests
 
USECC=mpicc
docker run --rm -it -e GITHUB_ACTIONS=TRUE -e CBRANCH=${CVER} -e FBRANCH=${FVER} -e H5VER=${H5VER} -e USE_CC=${USECC} -e USE_BUILDSYSTEM=both -v $(pwd)/environments:/environments -v $(pwd)/netcdf-c:/netcdf-c -v $(pwd)/netcdf-fortran:/netcdf-fortran docker.unidata.ucar.edu/nctests