
#!/bin/bash

########################################
# 16. REGEX IN BASH: STRING MATCHING
########################################

str="IMG_20250501_074512.jpg"

# Basic regex match
if [[ "$str" =~ ^IMG_([0-9]{8})_([0-9]{6})\.jpg$ ]]; then
    echo "Date: ${BASH_REMATCH[1]}"
    echo "Time: ${BASH_REMATCH[2]}"
fi

# Media filename matching
file="Bohemian Rhapsody (1975) - Queen.flac"
if [[ "$file" =~ ^(.+)\ \([0-9]{4}\)\ \-\ (.+)\.(mp3|flac|mp4|mkv)$ ]]; then
    title="${BASH_REMATCH[1]}"
    artist="${BASH_REMATCH[2]}"
    echo "Title: $title"
    echo "Artist: $artist"
elif [[ "$file" =~ ^(.+)\ \-\ (.+)\.(mp3|flac|mp4|mkv)$ ]]; then
    artist="${BASH_REMATCH[1]}"
    title="${BASH_REMATCH[2]}"
    echo "Title: $title"
    echo "Artist: $artist"
else
    echo "Unknown format"
fi

########################################
# 17. REGEX IN FIND COMMAND
########################################

# Files ending with a number
find . -regex '.*[0-9]\.jpg'

# Files with 8 digit date (e.g. 20250501)
find . -type f -regextype posix-extended -regex '.*[0-9]{8}.*\.jpg'

########################################
# 18. GREP WITH REGEX
########################################

# Print lines with 4-digit numbers
grep -E '[0-9]{4}' file.txt

# Match exact date format YYYYMMDD
grep -E '^IMG_[0-9]{8}_[0-9]{6}\.jpg$' <<< "IMG_20250501_074512.jpg"

# Extract filenames with "Queen"
grep "Queen" media/*.flac

########################################
# 19. SED & REGEX
########################################

# Replace spaces with underscores in filenames
for f in *; do
    newname=$(echo "$f" | sed 's/ /_/g')
    mv "$f" "$newname"
done

# Extract just the title from "Artist - Title.mp3"
echo "Radiohead - Karma Police.mp3" | sed -E 's/^.+ - (.+)\.mp3/\1/'

# Remove everything after a dash
echo "Artist - Title.mp3" | sed -E 's/ - .*//'

########################################
# 20. AWK & REGEX
########################################

# Extract artist and title
echo "Radiohead - Karma Police.mp3" | awk -F' - ' '{print "Artist:", $1; print "Title:", $2}'

# Match and process only files with year
awk '/\([0-9]{4}\)/ {print $0}' media_list.txt

########################################
# 21. REGEX EXAMPLES FOR FILE HANDLING
########################################

# Match files like IMG_YYYYMMDD_HHMMSS.jpg
regex='^IMG_([0-9]{8})_([0-9]{6})\.jpg$'

for f in photos/*.jpg; do
    fname=$(basename "$f")
    if [[ "$fname" =~ $regex ]]; then
        date=${BASH_REMATCH[1]}
        time=${BASH_REMATCH[2]}
        hour=${time:0:2}
        echo "File: $fname — Date: $date, Time: $time, Hour: $hour"
    fi
done
