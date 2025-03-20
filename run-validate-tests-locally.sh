#!/bin/bash

CVER=v4.9.2
FVER=v4.6.1
H5VER=1.14.6
USECC=gcc
ENVDIR="$(pwd)/environments"
set -e 
dosummary() {
    echo "Testing Macro Functionality"
    echo "==========================="
    echo -e "\to C Version: ${CVER}"
    echo -e "\to Fortran Version: ${FVER}"
    echo -e "\to HDF5 Version: ${H5VER}"
    echo -e "\to Compiler: ${USECC}" 
    echo ""
    echo "This will delete netcdf-c/ and netcdf-fortran/ if they exist !!!!!"
    echo "ARE YOU SURE?"
    echo ""
    echo "Press [Return] to continue"
    read    
}

dosummary

rm -rf netcdf-c netcdf-fortran
git clone git@github.com:Unidata/netcdf-c && cd netcdf-c && git checkout ${CVER} && cd ..
git clone git@github.com:Unidata/netcdf-fortran && cd netcdf-fortran && git checkout ${FVER} && cd ..

###
# Test NetCDF-c
###
docker run --rm -it -e GITHUB_ACTIONS=TRUE -e REPO_TYPE=c -e FBRANCH=${FVER} -v $(pwd)/netcdf-c:/github/workspace -e H5VER=${H5VER} -e USE_CC=${USECC} -e USE_BUILDSYSTEM=both -v ${ENVDIR}:/environments  docker.unidata.ucar.edu/nctests

###
# Test NetCDF-fortran
###
docker run --rm -it -e GITHUB_ACTIONS=TRUE -e REPO_TYPE=fortran -e CBRANCH=${CVER} -v $(pwd)/netcdf-fortran:/github/workspace -e H5VER=${H5VER} -e USE_CC=${USECC} -e USE_BUILDSYSTEM=both -v ${ENVDIR}:/environments  docker.unidata.ucar.edu/nctests