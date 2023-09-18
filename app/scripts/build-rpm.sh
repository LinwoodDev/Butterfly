# Read version from pubspec
BUTTERFLY_VERSION_REGEX="version:\s(.+)\+(.+)"
[[ $(grep -E "${BUTTERFLY_VERSION_REGEX}" pubspec.yaml) =~ ${BUTTERFLY_VERSION_REGEX} ]]
BUTTERFLY_VERSION="${BASH_REMATCH[1]}"
# Replace - with ~ to match RPM versioning
RPM_VERSION=$(echo $BUTTERFLY_VERSION | sed 's/-/~/g')
echo "Building Butterfly $RPM_VERSION"
rm -rf build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
# Copy files
cp linux/linwood-butterfly.spec build/SPECS/linwood-butterfly.spec
cp -r build/linux/x64/release/bundle build/SOURCES/linwood-butterfly-$RPM_VERSION
chmod +x build/SOURCES/linwood-butterfly-$RPM_VERSION/butterfly
cp linux/debian/usr/share/applications/dev.linwood.butterfly.desktop build/SOURCES/linwood-butterfly-$RPM_VERSION/linwood-butterfly.desktop
# Change second line of spec file Version: to match version
sed -i "2s/.*/Version: $RPM_VERSION/" build/SPECS/linwood-butterfly.spec
# Change fourth line of desktop file Exec=butterfly %f to Exec=linwood-butterfly %f
sed -i "4s/.*/Exec=linwood-butterfly %f/" build/SOURCES/linwood-butterfly-$RPM_VERSION/linwood-butterfly.desktop
# Create tar
cd build/SOURCES/
# Fix .so files using patchelf
cd linwood-butterfly-$RPM_VERSION/lib
for file in *.so; do
  echo "Fixing $file"
  patchelf --set-rpath '$ORIGIN' $file
done
cd ../../
tar --create --file linwood-butterfly-$RPM_VERSION.tar.gz linwood-butterfly-$RPM_VERSION
cd ../../
# Build RPM
rpmbuild -ba build/SPECS/linwood-butterfly.spec --define "_topdir $(pwd)/build"
# Copy RPM to build folder
cp build/RPMS/x86_64/linwood-butterfly-*.rpm build/linwood-butterfly-linux.rpm
