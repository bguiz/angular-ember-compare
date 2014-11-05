#!/bin/bash

IMG_OUT_FOLDER="manuscript/images"
mkdir -p ${IMG_OUT_FOLDER}

#For images that do no need any processing
PNG_FOLDER="manuscript/png"
cp ${PNG_FOLDER}/*.png "${IMG_OUT_FOLDER}/"

#If the gimp format conversion fails, ensure that you have xcftools installed
#apt-get install xcftools
XCF_FOLDER="manuscript/gimp"

for xcf in $( ls ${XCF_FOLDER}/*.xcf ) ; do
	xcf=$(basename ${xcf})
	echo "${XCF_FOLDER}/${xcf} --> ${IMG_OUT_FOLDER}/${xcf%.*}.png"
	xcf2png "${XCF_FOLDER}/${xcf}" -o "${IMG_OUT_FOLDER}/${xcf%.*}.png"
done

for thing in "model" "view" "controller" "routing" "component" ; do
    for spa in "angularjs" "emberjs" ; do
        montage "${XCF_FOLDER}/${spa}.png" "${XCF_FOLDER}/${thing}.png" -shadow -background None -geometry 200X200+2+1  "${IMG_OUT_FOLDER}/${spa}-${thing}.png"
    done
    montage "${XCF_FOLDER}/angularjs.png" "${XCF_FOLDER}/${thing}.png" "${XCF_FOLDER}/emberjs.png" -shadow -background None -geometry 200X200+2+1  "${IMG_OUT_FOLDER}/spa-${thing}.png"
done
montage "${XCF_FOLDER}/model.png" "${XCF_FOLDER}/view.png" "${XCF_FOLDER}/controller.png" -shadow -background None -geometry 200X200+2+1  "${IMG_OUT_FOLDER}/model-view-controller.png"
montage "${XCF_FOLDER}/angularjs.png" "${XCF_FOLDER}/emberjs.png" -shadow -background None -geometry 200X200+2+1  "${IMG_OUT_FOLDER}/angularjs-emberjs.png"

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
