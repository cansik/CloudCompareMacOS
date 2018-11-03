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

# create libe57 prebuilt folder
mkdir -p libE57Format/lib
mkdir -p libE57Format/include/E57Format
cp ../contrib/libE57Format/libE57Format.a libE57Format/lib/libE57Format.a
cp -R -a ../contrib/libE57Format/include/. libE57Format/include/E57Format

# prepare cmake
XERCES_ROOT="/usr/local/Cellar/xerces-c/3.2.2" CMAKE_PREFIX_PATH="/usr/local/Cellar/qt/5.11.2/lib/cmake/" \
ccmake \
-D OPTION_USE_LIBE57FORMAT="ON" \
-D QT5_ROOT_PATH="/usr/local/Cellar/qt/5.11.2/" \
-D LIBE57FORMAT_INSTALL_DIR="libE57Format/" \
-D LIBE57FORMAT_LIBRARY_DEBUG="libE57Format/" \
-D LIBE57FORMAT_LIBRARY_RELEASE="libE57Format/" \
..

make