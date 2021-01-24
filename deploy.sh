#!/usr/bin/env sh

# build
npm run build

# push subtree
git add .
git commit -m "new release"
git subtree push --prefix dist origin gh-pages