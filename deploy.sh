#!/usr/bin/env sh

# build
npm run build

# push subtree
git subtree push --prefix dist origin gh-pages