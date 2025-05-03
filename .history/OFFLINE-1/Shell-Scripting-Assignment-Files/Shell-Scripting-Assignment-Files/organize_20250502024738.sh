#!/bin/sh

extract_ids(){
    filename=$(basename "$1")
    serial=$(echo "$filename" | cut -d'_' -f4)
}