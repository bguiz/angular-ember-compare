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

for thing in "model" "view" "controller" ; do
    for spa in "angularjs" "emberjs" ; do
        montage "${XCF_FOLDER}/${spa}.png" "${XCF_FOLDER}/${thing}.png" -shadow -background None -geometry 200X200+2+1  "${IMG_OUT_FOLDER}/${spa}-${thing}.png"
    done
    montage "${XCF_FOLDER}/angularjs.png" "${XCF_FOLDER}/${thing}.png" "${XCF_FOLDER}/emberjs.png" -shadow -background None -geometry 200X200+2+1  "${IMG_OUT_FOLDER}/spa-${thing}.png"
done

#If the gitbook commands fail, ensure that you have gitbook installed
#npm install -g gitbook
echo "Building static site"
gitbook build ./content/ -o ./dist/static
# echo "Building PDF"
# gitbook build ./content/ -f pdf -o ./dist/pdf
# echo "Building single page"
# gitbook build ./content/ -f page -o ./dist/page
# echo "Building JSON"
# gitbook build ./content/ -f json -o ./dist/json
