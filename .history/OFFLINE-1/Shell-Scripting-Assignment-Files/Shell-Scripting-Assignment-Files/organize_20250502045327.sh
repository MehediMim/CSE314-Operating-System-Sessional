#!/bin/sh

extract_ids(){
    filename=$(basename "$1")
    idWithExtension=$(echo "$filename" | cut -d'_' -f4)
    id=$(echo "$idWithExtension" | cut -d'.' -f1)
    echo $id
}

extract_extension(){
    filename=$(basename "$1")
    extension=$(echo "$filename" | cut -d'.' -f2)
    echo $extension
}

get_file_path(){
    if [ -f "$1"  ]
    then
        extension=`extract_extension "$1"`
        if [ $extension == "c" ] || [ $extension == "cpp" ] || [ $extension == "java" ] || [ $extension == "py" ]
        then
        echo "1"
        fi
    elif [ -d "$1" ]
    then
        for path in "1"/*
        do
        get_file_path "path"
        done
    fi
    
}
organize_files(){
    unzipped_file="$1"
    unzippedFolderName="unzippedTrashBin"

    rm -rf "$unzippedFolderName"

    mkdir "$unzippedFolderName"
    unzip -q "$unzipped_file" -d "$unzippedFolderName"

    echo "unzipped"

    code=$(get_file_path "$unzippedFolderName")

    if [ -z "$code" ]
    then
        echo "No such file was found"
        return
    fi
        
    studentID=$(extract_ids "$code")
    extension=$(extract_extension "$code")

}



extract_ids "$1"
extract_extension "$1"
organize_files "$1"