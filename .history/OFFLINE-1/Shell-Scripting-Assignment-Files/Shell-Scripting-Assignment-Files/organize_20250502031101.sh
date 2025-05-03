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

extract_ids "$1"
extract_extension "$1"