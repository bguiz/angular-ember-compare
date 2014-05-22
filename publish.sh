#!/bin/bash

TGT="../angular-ember-compare-publish"

rm -rf dist/static
rm -rf ${TGT}/*
./build.sh
cp -r dist/static/* ${TGT}/
rm -rf ${TGT}/gimp
mkdir ${TGT}/pdf
cp -r dist/pdf/index.pdf ${TGT}/pdf/angularjs-emberjs-compare.bguiz.com.pdf
