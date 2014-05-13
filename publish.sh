#!/bin/bash

rm -rf dist/static
rm -rf ../angular-ember-compare-publish/*
./build.sh
cp -r dist/static/* ../angular-ember-compare-publish/
rm -rf ../angular-ember-compare-publish/gimp
