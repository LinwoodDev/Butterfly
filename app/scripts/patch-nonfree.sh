rm nonfree.patch
git restore .
git restore --staged .
git diff > nonfree.patch
git add nonfree.patch
git restore .