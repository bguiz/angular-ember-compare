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

LEANPUB="../../angularjs-emberjs-compare/manuscript"
cd ${CD}
rm -rf "${LEANPUB}/"
mkdir "${LEANPUB}/"
cd "${CD}/manuscript/"
cp -r Book.txt Subset.txt README.md images/ intro/ mvc/ routing/ components/ roundup/ "../${LEANPUB}/"
cd ${CD}
