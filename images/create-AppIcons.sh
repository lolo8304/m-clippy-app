
convert_to_gemetry() {
    input=$1
    ext=$2
    geo_orig=$3
    width=$3
    factor=$4
    count_s=$4
    count=$5
    geo=$(( geo_orig * factor ))

    for (( c=${count_s}; c<$count; c++ ))
    do  
        echo "create ${input}_${width}x${width}@${factor}x.${ext}"
        convert ${input}.${ext} -geometry ${geo}x${geo} AppIcon.appiconset/${input}_${width}x${width}@${factor}x.${ext}
        factor=$(( factor + 1 ))
        geo=$(( geo_orig * factor ))
    done
    echo "create ${input}_${width}x${width}@${factor}x.${ext}"
    convert ${input}.${ext} -geometry ${geo}x${geo} AppIcon.appiconset/${input}_${width}x${width}@${factor}x.${ext}

}


convert_to_gemetry logo jpg 20 1 3
convert_to_gemetry logo jpg 29 1 3
convert_to_gemetry logo jpg 40 1 3
convert_to_gemetry logo jpg 60 2 3
convert_to_gemetry logo jpg 76 1 2
convert_to_gemetry logo jpg 167 1 1
convert_to_gemetry logo jpg 1024 1 1

convert_to_gemetry logo jpg 48 1 1
convert_to_gemetry logo jpg 55 1 1
convert_to_gemetry logo jpg 44 2 2
convert_to_gemetry logo jpg 50 2 2
convert_to_gemetry logo jpg 86 2 2
convert_to_gemetry logo jpg 98 2 2
convert_to_gemetry logo jpg 108 2 2
convert_to_gemetry logo jpg 16 1 2
convert_to_gemetry logo jpg 32 1 2
convert_to_gemetry logo jpg 128 1 2
convert_to_gemetry logo jpg 256 1 2
convert_to_gemetry logo jpg 512 1 2

cp AppIcon.appiconset/* /Users/Lolo/git/m-clippy/m-clippy-app/m-clippy/m-clippy/Assets.xcassets/AppIcon.appiconset
