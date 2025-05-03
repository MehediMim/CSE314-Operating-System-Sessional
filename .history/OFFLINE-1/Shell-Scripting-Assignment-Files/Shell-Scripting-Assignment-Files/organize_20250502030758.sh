#!/bin/sh

extract_ids(){
    filename=$(basename "$1")
    id=$(echo "$filename" | cut -d'_' -f4)
    id=$(echo "$id" | cut -d'.' -f1)
    echo $id
}

extract_ids "$1"