#!/bin/bash
main(){
    input="photos_input"
    mkdir -p "mim/morning" "mim/afternoon" "mim/evening"

   for p in "$input"/*.jpg
   do
        filename=$(basename "$p")
        # echo $filename
        hour=$(echo "$filename" | cut -d'_' -f3 | cut -c1-2)
        if [[ -z "$hour" ]]; then
        echo "Warning: Could not extract hour from $filename"
        continue
        fi
        
        if [ $hour -lt 12 ] && [ $hour -ge 0 ]
        then
            
            str="morning"
        elif [ $hour -lt 18 ] && [ $hour -ge 12 ]
        then
            
            str="afternoon"
        else
        # then
            str="evening"
        fi

        newname="${str}_${filename}"
        cp "$p" "mim/$str/$newname"
        
    done
    echo "Morning: $(ls mim/morning | wc -l)" > mim/counts.txt
    echo "Afternoon: $(ls mim/afternoon | wc -l)" >> mim/counts.txt
    echo "Evening: $(ls mim/evening | wc -l)" >> mim/counts.txt

}
main