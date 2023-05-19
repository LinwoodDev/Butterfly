rm nonfree.patch
git restore .
git diff --staged > build/nonfree.patch
git restore --staged .
git restore .
cp build/nonfree.patch .
git add nonfree.patch
git restore .
git clean -f