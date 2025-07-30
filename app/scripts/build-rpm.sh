#!/bin/bash

# Default values for architecture
DIRECTORY_ARCH="x64"  # Default directory name
BINARY_ARCH="x86_64"  # Default binary name
RPM_ARCH="x86_64"     # Default RPM architecture

# Parse command-line arguments
while getopts "d:b:" opt; do
  case $opt in
    d) DIRECTORY_ARCH="$OPTARG" ;;  # Set the directory architecture
    b) BINARY_ARCH="$OPTARG" ;;    # Set the binary architecture
    *) 
      echo "Usage: $0 [-d directory_arch] [-b binary_arch]"
      exit 1
      ;;
  esac
done

RPM_ARCH="$DIRECTORY_ARCH"  # Set RPM architecture based on directory architecture
if [ "$RPM_ARCH" = "x64" ]; then
  RPM_ARCH="x86_64"
elif [ "$RPM_ARCH" = "arm64" ]; then
  RPM_ARCH="aarch64"
fi

# Read version from pubspec
BUTTERFLY_VERSION_REGEX="version:\s(.+)\+(.+)"
[[ $(grep -E "${BUTTERFLY_VERSION_REGEX}" pubspec.yaml) =~ ${BUTTERFLY_VERSION_REGEX} ]]
BUTTERFLY_VERSION="${BASH_REMATCH[1]}"

# Replace - with ~ to match RPM versioning
RPM_VERSION=$(echo $BUTTERFLY_VERSION | sed 's/-/~/g')
CURRENT_DIR=$(pwd)
echo "Building Butterfly $RPM_VERSION for $DIRECTORY_ARCH/$BINARY_ARCH ($RPM_ARCH)"

# Clean and set up build directories
rm -rf build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Copy files
cp linux/rpm/linwood-butterfly.spec build/SPECS/linwood-butterfly.spec
cp -r build/linux/${DIRECTORY_ARCH}/release/bundle build/SOURCES/linwood-butterfly-$RPM_VERSION
chmod 755 build/SOURCES/linwood-butterfly-$RPM_VERSION/butterfly
mv build/SOURCES/linwood-butterfly-$RPM_VERSION/butterfly build/SOURCES/linwood-butterfly-$RPM_VERSION/linwood-butterfly
cp linux/rpm/linwood-butterfly.desktop build/SOURCES/linwood-butterfly-$RPM_VERSION/linwood-butterfly.desktop

# Update .spec file with the correct version
sed -i "2s/.*/Version: $RPM_VERSION/" build/SPECS/linwood-butterfly.spec

# Create tarball
cd build/SOURCES/
# Fix .so files using patchelf
cd linwood-butterfly-$RPM_VERSION/lib
for file in *.so; do
  PATCHELF_OUTPUT=$(patchelf --print-rpath "$file")
  echo "Checking $file: $PATCHELF_OUTPUT"
  # Skip file if PATCHELF_OUTPUT does not contain CURRENT_DIR
  if [[ ! $PATCHELF_OUTPUT =~ $CURRENT_DIR ]]; then
    echo "Skipping $file"
    continue
  fi
  echo "Fixing $file"
  patchelf --set-rpath '$ORIGIN' "$file"
done
cd ../../
tar --create --file linwood-butterfly-$RPM_VERSION.tar.gz linwood-butterfly-$RPM_VERSION
cd ../../

# Build RPM
QA_RPATHS=$[ 0x0001|0x0010 ] rpmbuild -bb build/SPECS/linwood-butterfly.spec --define "_topdir $(pwd)/build"

# Copy the RPM to the build folder
cp build/RPMS/${RPM_ARCH}/linwood-butterfly-*.rpm build/linwood-butterfly-linux-${BINARY_ARCH}.rpm
