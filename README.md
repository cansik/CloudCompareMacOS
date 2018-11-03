# CloudCompare MacOS
[CloudCompare](https://github.com/CloudCompare/CloudCompare) MacOS prebuilt* with extended plugins. The ideas are based on the blog post of [Ryan Baumann ](https://ryanfb.github.io/etc/2018/04/19/building_cloudcompare_with_e57_support_on_os_x.html).

\* **At the moment there are not prebuilt binaries, because the build process is realtive to your filepath. I am still working on it!**

## Buildscript

I have also combined all the steps to build it from source into a bash script. Just run it and the resulting binaries should be in `cloudcompare/build/qCC`.

```bash
./build
```

## Build DIY

### Prerequisites
Download and install following prerequisites. Check the version number, otherwise the build will break:

- xerces-c at version `3.2.2`
- qt at version `5.11.2`
- cmake at version `3.12.3`

```bash
brew install xerces-c qt cmake
```

I recommend to set following variables for this bash session, because you have to use it later multiple times:

```bash
XERCES_ROOT="/usr/local/Cellar/xerces-c/3.2.2"
QT5_ROOT_PATH="/usr/local/Cellar/qt/5.11.2"
E57BUILD_OUTPUT="E57Format-2.0-x86_64-darwin"
```

### Sources
Download sources from the cloud compare repository. If a newer version breaks this build example, use this version: [086ef51](https://github.com/CloudCompare/CloudCompare/commit/086ef5195535066cb01cd7fd4bad43c9a09e066f)

```bash
git clone --recursive https://github.com/cloudcompare/trunk.git cloudcompare
```

### Configure
To configure and build, first create the output folder:

```bash
cd ../..
mkdir build && cd build
```

Then copy the libE57Format into this folder (otherwise you always link to the source):

```bash
mkdir -p "$E57BUILD_OUTPUT/lib"
mkdir -p "$E57BUILD_OUTPUT/include/E57Format"
cp "../contrib/libE57Format/libE57Format.a" "$E57BUILD_OUTPUT/lib/libE57Format.a"
cp -R -a "../contrib/libE57Format/include/." "$E57BUILD_OUTPUT/include/E57Format"
```

Configure cmake with ccmake:

```bash
XERCES_ROOT="$XERCES_ROOT" CMAKE_PREFIX_PATH="$QT5_ROOT_PATH/lib/cmake/" \
ccmake \
-D OPTION_USE_LIBE57FORMAT="ON" \
-D QT5_ROOT_PATH="$QT5_ROOT_PATH/" \
-D LIBE57FORMAT_INSTALL_DIR="$E57BUILD_OUTPUT/" \
-D LIBE57FORMAT_LIBRARY_DEBUG="$E57BUILD_OUTPUT/lib/libE57Format.a" \
..
```

Press following keys to configure and generate (sometimes `e` to skip warnings!):

```
c -> c -> g
```

### Build

Then run `make` and the software should be built into `qCC`:

```bash
make
```
