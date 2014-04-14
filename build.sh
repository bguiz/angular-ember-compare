#!/bin/bash

gitbook build ./content/ -f page -o ./dist/page
gitbook build ./content/ -f json -o ./dist/json
gitbook build ./content/ -o ./dist/static
