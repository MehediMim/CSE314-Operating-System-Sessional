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
        extension=$(extract_extension "$1")
        
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

        if $nolc 
        then
            linecount=$(wc -l < "$file")
            echo "Line Count : $linecount"
        fi

        if $nocc
        then
            case "$extension" in
                py)
                    commentCount=$(grep -cE '^\s*#' "$file")
                ;; 
                cpp|c|java)
                    commentCount=$(grep -cE '^\s*//' "$file")
                ;; 
                *)
                    commentCount=0
                ;;
            esac
        echo "Comment Count : $commentCount"
        fi
    fi
}

organize_files(){
    unzipped_file="$1"
    targetFolder="$2"
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

    mkdir -p "$targetFolder/$destinationFolder"
    cp "$code" "$targetFolder/$destinationFolder/$name"

    analyze "$targetFolder/$destinationFolder/$name"

}
run_code(){
    
}

main(){

    submissionFolder="$1"
    targetFolder="$2"
    testFolder="$3"
    answerFolder="$4"

    verbose =false
    noexecute =true
    nolc=true
    nocc=true
    nofc=true

    shift 4

    for arg in "$@"
    do
        case "$arg" in 
        -v)
            verbose=true
        ;;
        -noexecute)
            noexecute=false
        ;;
        -nolc)
            nolc=false
        ;;
        -nocc)
            nocc=false
        ;;
        -nofc)
            nofc=false
        ;;

    mkdir -p "$targetFolder"
    for i in "$submissionFolder/"*.zip
    do
        organize_files "$i" "$targetFolder"
    done
}


main