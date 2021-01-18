#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist

# push into gh-pages branch
git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:aurelie/beat-saber-stretching.git master:gh-pages

cd -