#!/bin/bash
main(){
    input="photos_input"
mkdir -p "mim/morning" "mim/afternoon" "mim/evening"

   for p in "$input/IMG_*.jpg"
   do
        filename=$(basename "$p")
        datetime=$(echo "$filename" | cut -d'_' -f2- |cut -d'.' -f1)
        hour=${datetime:9:2}
        hour=$((10#$hour))
        
        if [ $hour -lt 12 ] && [ $hour -ge 0 ]
        then
            
            str="morning"
        elif [ $hour -lt 18 ] && [ $hour -ge 11 ]
        then
            
            str="afternoon"
        elif [ $hour -lt 24 ] && [ $hour -ge 17 ]
        then
            
            str="evening"
        fi

        newname="${str}_${filename}"
        mv "$p" "mim/$str/$newname"
        
    done
}
main