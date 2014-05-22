#!/bin/bash

TGT="../angular-ember-compare-publish"
CD=$(pwd)

rm -rf dist/static
rm -rf ${TGT}/*
cd ${TGT}
git checkout -- CNAME
cd ${CD}

./build.sh
cp -r dist/static/* ${TGT}/
rm -rf ${TGT}/{gimp,_book}

mkdir ${TGT}/pdf
cp -r dist/pdf/index.pdf ${TGT}/pdf/angularjs-emberjs-compare.bguiz.com.pdf

