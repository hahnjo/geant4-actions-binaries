#!/bin/sh

set -e

if [ -z "$GEANT4_VERSION" ]; then
  echo "Please set GEANT4_VERSION!"
  exit 1
fi

# Download the source code.
dir="geant4.$GEANT4_VERSION"
archive="$dir.tar.gz"
url="https://geant4-data.web.cern.ch/releases/$archive"
wget "$url"
tar xf "$archive"

# Build the libraries and install them, including the data files.
mkdir build
cd build
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=../Geant4 \
  -DGEANT4_INSTALL_DATA=ON \
  -DGEANT4_INSTALL_EXAMPLES=OFF \
  -DGEANT4_BUILD_MULTITHREADED=ON \
  -DGEANT4_USE_GDML=ON \
  "../$dir"
make -j4
make install

# Delete optional data files.
cd ..
rm -rf Geant4/share/*/data/G4NDL*
rm -rf Geant4/share/*/data/RealSurface*
