#!/bin/bash
main(){
    foldername="$1"


    mkdir blueprints
    echo $foldername
    for folder in "$foldername"/*
    do
        # echo $file
        fn=$(basename "$folder")
        # echo $fn
        # fn=$(basename "$fn")
        
        for file in "$foldername/$fn"/*.dat
        do
            # echo $file
            f=$(basename "$file")
            # echo $f
            newname="${fn}_${f}"
            echo $newname
            echo $fn
            cp "$file" "blueprints/$newname"


            # f...

            id=$(echo "$f" | cut -d'_' -f2)
            category=$(echo "$f" | cut -d'_' -f3 | cut -d'.' -f1)
            echo $id
            echo $arr['$category']
            e=$(($id%2))

            if [ $e -eq 0 ]
            then

                # for j in arr[]
                # do
                #     if [ $d -eq arr[j][0] ]
                #     then
                #     arr[j][1]++
                #     fi
                # done
                arr['$category']+=1
            fi

        done

    done
    echo "$category $arr['$category]}" >> inventory_summary.txt

}
main "$@"