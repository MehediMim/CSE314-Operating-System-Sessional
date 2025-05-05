#!/bin/bash
main(){
    input="photos_input"
mkdir -p "mim/morning" "mim/afternoon" "mim/evening"

   for p in "$input"/*.jpg
   do
        filename=$(basename "$p")
        echo $filename
        hour=$(echo "$datetime" | cut -d'_' -f2 | cut -c1-2)
        if [[ -z "$hour" ]]; then
        echo "Warning: Could not extract hour from $filename"
        continue
        fi
        
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