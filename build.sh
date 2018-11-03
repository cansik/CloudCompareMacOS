#!/usr/bin/env bash

# clean up first
rm -rf cloudcompare

# install prerequisites
brew install xerces-c qt cmake jq

# download from sources
git clone --recursive https://github.com/cloudcompare/trunk.git cloudcompare

# brew info xerces-c --json=v1 | jq ""
# XERCES_ROOT=""

# make libE57Format
cd cloudcompare/contrib/libE57Format
XERCES_ROOT="/usr/local/Cellar/xerces-c/3.2.2" cmake .
make

# build cloud compare
cd ../..
mkdir build && cd build

# prepare cmake
XERCES_ROOT="/usr/local/Cellar/xerces-c/3.2.2" CMAKE_PREFIX_PATH="/usr/local/Cellar/qt/5.11.2/lib/cmake/" \
ccmake \
-D OPTION_USE_LIBE57FORMAT="ON" \
-D QT5_ROOT_PATH="/usr/local/Cellar/qt/5.11.2/" \
-D LIBE57FORMAT_INSTALL_DIR="${CMAKE_CURRENT_SOURCE_DIR}/contrib/libE57Format/" \
-D LIBE57FORMAT_LIBRARY_DEBUG="${CMAKE_CURRENT_SOURCE_DIR}/contrib/libE57Format/" \
-D LIBE57FORMAT_LIBRARY_RELEASE="${CMAKE_CURRENT_SOURCE_DIR}/contrib/libE57Format/" \
..

make