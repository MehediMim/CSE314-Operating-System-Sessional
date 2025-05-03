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
    if [ -f "$1" ]
    then
        extension=`extract_extension "$1"`
        if [ "$extension" = "c" ] || [ "$extension" = "cpp" ] || [ "$extension" = "java" ] || [ "$extension" = "py" ]
        then
        echo "$1"
        fi
    elif [ -d "$1" ]
    then
        for path in "$1"/*
        do
        get_file_path "$path"
        done
    fi
    
}
analyze(){
    file="$1"
    extension=$(extract_extension "$file" ) 
    if [ -f "$file" ]
    then
        linecount=$(wc -l < "$file")

        case ($extension) in
            py)
                commentCount=$(grap -cE '^\s*#' "$file")
            ;; 
            cpp|c|java)
                commentCount=$(grap -cE '^\s*//' "$file")
            ;; 
            default)
                commentCount=0
            ;;
        esac
    fi
    echo "Line Count : $linecount"
    echo "Comment Count : $commentCount"
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
        
    studentID=$(extract_ids "$1")
    extension=$(extract_extension "$code")
    # echo $studentID
    # echo $extension

    case "$extension" in
        c)
            lang="C"
            name="main.c"
        ;;
        cpp)
            lang="C++"
            name="main.cpp"
        ;;
        java)
            lang="Java"
            name="main.java"
        ;;
        py)
            lang="Python"
            name="main.py"
        ;;
        *)
            echo "No Such Language Found"
        ;;    
    esac

    destinationFolder="$lang/$studentID"

    mkdir -p "targets/$destinationFolder"
    cp "$code" "targets/$destinationFolder/$name"

}

main(){
    for i in "Workspace/submissions/"*.zip
    do
        organize_files "$i"
    done
}


main