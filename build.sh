#!/bin/bash

#If the gitbook commands fail, ensure that you have gitbook installed
#npm install -g gitbook
echo "Building static site"
gitbook build ./manuscript/ -o ./dist/static
# echo "Building PDF"
# gitbook build ./manuscript/ -f pdf -o ./dist/pdf
# echo "Building single page"
# gitbook build ./manuscript/ -f page -o ./dist/page
# echo "Building JSON"
# gitbook build ./manuscript/ -f json -o ./dist/json

# For leanpub
echo "README.md" > manuscript/Book.txt
# TODO find a better way than two chained seds (perhaps just one is enough)
cat manuscript/SUMMARY.md | sed 's/.*\(([^)]*)\).*/\1/g' | sed 's/^.\(.*\).$/\1/' >> manuscript/Book.txt
