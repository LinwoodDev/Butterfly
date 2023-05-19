DEL nonfree.patch
git restore .
git diff --staged > build/nonfree.patch
git restore --staged .
git restore .
MOVE build\nonfree.patch .
git add nonfree.patch
git restore .