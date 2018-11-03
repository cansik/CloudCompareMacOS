# CloudCompare MacOS
[CloudCompare](https://github.com/CloudCompare/CloudCompare) MacOS prebuilt with extended plugins. The ideas are based on the blog post of [Ryan Baumann ](https://ryanfb.github.io/etc/2018/04/19/building_cloudcompare_with_e57_support_on_os_x.html).

## Buildscript

I have also combined all the steps to build it from source into a bash script. Just run it and the resulting binaries should be in `cloudcompare/build/qCC`.

```bash
./build
```

## Build it yourself

### Prerequisites
Download and install following prerequisites. Check the version number, otherwise the build will break:

- xerces-c at version `3.2.2`
- qt at version `5.11.2`
- cmake at version `3.12.3`

```bash
brew install xerces-c qt cmake
```

### Sources
Download sources from the cloud compare repository. If a newer version breaks this build example, use this version: [086ef51](https://github.com/CloudCompare/CloudCompare/commit/086ef5195535066cb01cd7fd4bad43c9a09e066f)

```bash
git clone --recursive https://github.com/cloudcompare/trunk.git cloudcompare
```

### Configure
To configure and build, first create the output folder:

```bash
cd ../..
mkdir build && cd build
```

Then copy the libE57Format into this folder (otherwise you always link to the source):

```bash
mkdir libE57Format
mkdir libE57Format/lib
cp ../contrib/libE57Format/libE57Format.a libE57Format/lib/libE57Format.a
cp -R ../contrib/libE57Format/include libE57Format/include
```

Configure cmake with ccmake:

```bash
XERCES_ROOT="/usr/local/Cellar/xerces-c/3.2.2" CMAKE_PREFIX_PATH="/usr/local/Cellar/qt/5.11.2/lib/cmake/" \
ccmake \
-D OPTION_USE_LIBE57FORMAT="ON" \
-D QT5_ROOT_PATH="/usr/local/Cellar/qt/5.11.2/" \
-D LIBE57FORMAT_INSTALL_DIR="libE57Format/" \
-D LIBE57FORMAT_LIBRARY_DEBUG="libE57Format/" \
-D LIBE57FORMAT_LIBRARY_RELEASE="libE57Format/" \
..
```

Press following keys to configure and generate (sometimes `e` to skip warnings!):

```
c -> c -> g
```

Then run `make` and the software should be built into `qCC`:

```bash
make
```
