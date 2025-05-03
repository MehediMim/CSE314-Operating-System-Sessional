#!/bin/sh

# extract_ids(){
#     filename=$(basename "$1")
#     serial=$(echo "$filename" | cut -d'_' -f4)
# }

filename=$(basename "$1")
echo "serial=$(echo "$filename" | cut -d'_' -f4)"