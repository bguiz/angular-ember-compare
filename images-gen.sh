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
montage "${IMG_OUT_FOLDER}/title_page.png" -shadow -background None -geometry 320X420+1+1  "${IMG_OUT_FOLDER}/title_page_small_shadow.png"
