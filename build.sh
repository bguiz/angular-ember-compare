#!/bin/bash

#If the gimp format conversion fails, ensure that you have xcftools installed
#apt-get install xcftools
XCF_FOLDER="content/gimp"
IMG_OUT_FOLDER="content/img"
mkdir -p ${IMG_OUT_FOLDER}
for xcf in $( ls ${XCF_FOLDER}/*.xcf ) ; do 
	xcf=$(basename ${xcf})
	echo "${XCF_FOLDER}/${xcf} --> ${IMG_OUT_FOLDER}/${xcf%.*}.png"
	xcf2png "${XCF_FOLDER}/${xcf}" -o "${IMG_OUT_FOLDER}/${xcf%.*}.png"
done

#If the gitbook commands fail, ensure that you have gitbook installed
#npm install -g gitbook
gitbook build ./content/ -f page -o ./dist/page
gitbook build ./content/ -f json -o ./dist/json
gitbook build ./content/ -o ./dist/static
