#!/bin/bash

#####################
# 1. VARIABLES
#####################
name="Mehedi"
age=22
readonly pi=3.14
echo "Name: $name, Age: $age"

#####################
# 2. CONDITIONALS
#####################
# if-else
if [ $age -gt 18 ]; then
    echo "Adult"
else
    echo "Minor"
fi

# nested
if [ $age -gt 18 ]; then
    echo "Adult"
elif [ $age -eq 18 ]; then
    echo "Just became adult"
else
    echo "Minor"
fi

# test command
if test -f "file.txt"; then
    echo "file.txt exists"
fi

#####################
# 3. LOOPING
#####################
# for loop
for i in {1..5}; do
    echo "Loop: $i"
done

# while loop
count=0
while [ $count -lt 5 ]; do
    echo "Count: $count"
    ((count++))
done

# until loop
until [ $count -le 0 ]; do
    echo "Until: $count"
    ((count--))
done

#####################
# 4. FUNCTIONS
#####################
greet() {
    echo "Hello $1"
}
greet "Murad"

return_test() {
    return 5
}
return_test
echo "Return code: $?"

#####################
# 5. FILE OPERATIONS
#####################
# create
touch myfile.txt
# write
echo "Hello" > myfile.txt
# append
echo "World" >> myfile.txt
# read
cat myfile.txt
# delete
rm -f myfile.txt

#####################
# 6. STRING OPERATIONS
#####################
str="Hello World"
echo "${str:0:5}"     # Substring
echo "${#str}"        # Length
if [[ $str == *World ]]; then
    echo "Ends with World"
fi

#####################
# 7. ARRAY
#####################
arr=(apple banana cherry)
echo "${arr[0]}"
arr[1]="blueberry"
for fruit in "${arr[@]}"; do echo $fruit; done

#####################
# 8. USER INPUT
#####################
read -p "Enter name: " user_name
echo "Hello $user_name"

#####################
# 9. COMMAND LINE ARGUMENTS
#####################
echo "Script name: $0"
echo "1st arg: $1"
echo "2nd arg: $2"
echo "Total args: $#"

#####################
# 10. FILE TESTS
#####################
file="somefile.txt"
[ -e "$file" ] && echo "Exists"
[ -f "$file" ] && echo "Regular file"
[ -d "$file" ] && echo "Directory"
[ -r "$file" ] && echo "Readable"
[ -x "$file" ] && echo "Executable"

#####################
# 11. NUMERIC & STRING COMPARISON
#####################
# Numeric
[ 5 -gt 3 ] && echo "5 > 3"
# String
[ "abc" = "abc" ] && echo "Strings match"

#####################
# 12. CASE STATEMENT
#####################
read -p "Enter a letter: " letter
case $letter in
    [a-z]) echo "Lowercase";;
    [A-Z]) echo "Uppercase";;
    *) echo "Other";;
esac

#####################
# 13. LOOPS WITH BREAK/CONTINUE
#####################
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        continue
    fi
    echo $i
    if [ $i -eq 8 ]; then
        break
    fi
done

#####################
# 14. REDIRECTION
#####################
echo "Output" > file.txt         # stdout
echo "Append" >> file.txt        # append stdout
ls notfound 2> error.txt         # stderr
ls notfound &> both.txt          # stdout + stderr
command < input.txt > output.txt

#####################
# 15. PROCESSING FILE LINE BY LINE
#####################
while IFS= read -r line; do
    echo "Line: $line"
done < file.txt

#####################
# 16. COMMAND SUBSTITUTION
#####################
current_time=$(date)
echo "Now: $current_time"

#####################
# 17. ARITHMETIC OPERATIONS
#####################
a=5
b=3
let c=a+b
echo "$a + $b = $c"
echo "$((a * b))"

#####################
# 18. TRAP & SIGNALS
#####################
trap "echo 'Interrupted'; exit" SIGINT
# sleep 10 (uncomment to test)

#####################
# 19. CRON FORMAT (for reference)
#####################
# ┌───────────── min (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of week (0 - 6) (Sunday to Saturday)
# │ │ │ │ │
# │ │ │ │ │
# * * * * * <command-to-execute>

#####################
# 20. ADVANCED (ASSOCIATIVE ARRAY)
#####################
declare -A colors
colors[apple]="red"
colors[banana]="yellow"
echo "${colors[apple]}"

#####################
# 21. DEBUGGING
#####################
# Run script with debug mode
# bash -x script.sh
# Add debug print manually
echo "Debug: var=$var"

#####################
# 22. FILE PERMISSIONS
#####################
chmod +x script.sh     # make executable
chmod 755 file         # rwxr-xr-x
chmod -R 777 folder    # recursive full access

#####################
# 23. SCRIPTS WITH FLAGS (GETOPT)
#####################
while getopts ":n:a:" opt; do
  case $opt in
    n) name=$OPTARG ;;
    a) age=$OPTARG ;;
    *) echo "Invalid option";;
  esac
done
echo "Name: $name, Age: $age"

#####################
# 24. MULTILINE COMMENT
#####################
: <<'END'
This is a
multiline comment
END


#########################################
# 25. ADVANCED STRING PARSING
#########################################
filename="IMG_20250501_074512.jpg"
# Extract date and time
date_part=$(echo "$filename" | cut -d'_' -f2)
time_part=$(echo "$filename" | cut -d'_' -f3 | cut -d'.' -f1)
hour=${time_part:0:2}
echo "Date: $date_part, Time: $time_part, Hour: $hour"

# Pattern Matching with Regex (Bash 3.0+)
if [[ "$filename" =~ IMG_([0-9]{8})_([0-9]{6})\.jpg ]]; then
    echo "Matched Date: ${BASH_REMATCH[1]}"
    echo "Matched Time: ${BASH_REMATCH[2]}"
fi

#########################################
# 26. ASSOCIATIVE ARRAY (Mapping Artist to Titles)
#########################################
declare -A media_map

# Populate array manually for example
media_map["Radiohead"]="Karma Police"
media_map["Queen"]="Bohemian Rhapsody"
media_map["Unknown"]="Interstellar"

# Print sorted catalog
for artist in "${!media_map[@]}"; do
    echo "$artist"
    echo "${media_map[$artist]}"
done | sort

#########################################
# 27. HANDLE FILES WITH SPACES
#########################################
# Always quote variables that may have spaces
for file in media/*; do
    [ -f "$file" ] || continue
    echo "File: $file"
done

#########################################
# 28. CREATE DIRECTORY IF NOT EXISTS
#########################################
mkdir -p morning afternoon evening

#########################################
# 29. RENAME FILES WITH PREFIX
#########################################
category="morning"
new_name="${category} $(basename "$filename")"
mv "$filename" "$category/$new_name"

#########################################
# 30. COUNT FILES IN EACH CATEGORY
#########################################
echo "Morning: $(ls morning | wc -l)" > counts.txt
echo "Afternoon: $(ls afternoon | wc -l)" >> counts.txt
echo "Evening: $(ls evening | wc -l)" >> counts.txt

#########################################
# 31. ESCAPING SPECIAL CHARACTERS
#########################################
# Use backslash or quotes to escape
echo "Using \$HOME to show home dir: $HOME"

#########################################
# 32. SORTING STRINGS
#########################################
echo -e "banana\napple\ncherry" | sort

#########################################
# 33. ESCAPED SPACES IN FILENAMES
#########################################
# Use double quotes in loops
for f in media/*.mp3; do
    [ -f "$f" ] || continue
    echo "Processing $f"
done

#########################################
# 34. CASE HANDLING FOR FILE FORMAT
#########################################
filename="Bohemian Rhapsody (1975) - Queen.flac"
if [[ "$filename" =~ ^(.+)\ \([0-9]{4}\)\ \-\ (.+)\.(mp3|flac|mp4|mkv)$ ]]; then
    title="${BASH_REMATCH[1]}"
    artist="${BASH_REMATCH[2]}"
elif [[ "$filename" =~ ^(.+)\ \-\ (.+)\.(mp3|flac|mp4|mkv)$ ]]; then
    artist="${BASH_REMATCH[1]}"
    title="${BASH_REMATCH[2]}"
else
    artist="Unknown"
    title="Unknown"
fi
echo "Artist: $artist"
echo "Title: $title"

#########################################
# 35. PRINTING TO FILE SAFELY
#########################################
echo "Hello" > file.txt      # overwrite
echo "World" >> file.txt     # append

#########################################
# 36. BASIC ERROR HANDLING
#########################################
if [ ! -d "$1" ]; then
    echo "Directory not found!"
    exit 1
fi

#########################################
# 37. GET FILE EXTENSION
#########################################
ext="${filename##*.}"
echo "Extension: $ext"

#########################################
# 38. GET BASENAME WITHOUT EXTENSION
#########################################
base="${filename%.*}"
echo "Basename: $base"

#########################################
# 39. FOR LOOP OVER FILE EXTENSIONS
#########################################
for ext in mp3 flac mp4 mkv; do
    echo "Handling *.$ext files"
done

#########################################
# 40. TEMPORARY VARIABLES IN LOOPS
#########################################
for file in *; do
    name=$(basename "$file")
    echo "File: $name"
done


#!/bin/bash

##################################################
# 1. LISTING FILES
##################################################
ls                            # List all files
ls -l                         # Long format
ls -lh                        # Human readable
ls -A                         # All except . and ..
find . -type f                # List all files recursively
find . -type d                # List all directories

##################################################
# 2. MASS RENAME FILES
##################################################
# Rename: remove spaces and lowercase all
for f in *\ *; do
    mv "$f" "${f// /_}"        # replace spaces with underscores
done

for f in *.JPG; do
    mv "$f" "$(basename "$f" .JPG).jpg"
done

# Rename with prefix/suffix
for file in *.jpg; do
    mv "$file" "renamed_$file"
done

##################################################
# 3. MOVE FILES BASED ON CONDITION
##################################################
# Move by extension
mkdir -p images videos audio
mv *.jpg images/
mv *.mp4 videos/
mv *.mp3 audio/

# Move based on name pattern
for file in IMG*; do
    hour=${file:13:2}
    if ((hour < 12)); then
        mv "$file" morning/
    elif ((hour < 18)); then
        mv "$file" afternoon/
    else
        mv "$file" evening/
    fi
done

##################################################
# 4. DELETE FILES
##################################################
rm file.txt                   # Delete file
rm *.tmp                      # Delete all .tmp files
rm -r folder/                 # Delete folder recursively
find . -name "*.bak" -delete  # Delete all .bak files
find . -type f -empty -delete # Delete all empty files

##################################################
# 5. COPY FILES
##################################################
cp file.txt backup.txt
cp *.jpg images/
cp -r project/ backup_project/

##################################################
# 6. COUNTING FILES
##################################################
echo "JPG count: $(ls *.jpg | wc -l)"
find . -type f | wc -l
find . -type f -name "*.mp3" | wc -l

##################################################
# 7. LOOP THROUGH FILES SAFELY
##################################################
shopt -s nullglob
for f in *.jpg; do
    echo "Found: $f"
done

##################################################
# 8. SORT FILES BY SIZE / NAME / TIME
##################################################
ls -lhS      # By size
ls -lt       # By modification time
ls | sort    # By name

##################################################
# 9. ARCHIVE AND COMPRESS FILES
##################################################
tar -czf archive.tar.gz *.jpg       # Create compressed archive
tar -xzf archive.tar.gz             # Extract
zip photos.zip *.jpg                # Zip
unzip photos.zip                    # Unzip

##################################################
# 10. FILE INFORMATION
##################################################
file photo.jpg                      # File type
stat photo.jpg                      # Details
du -sh photo.jpg                    # Size

##################################################
# 11. FIND & EXECUTE
##################################################
find . -name "*.jpg" -exec mv {} images/ \;
find . -type f -name "*.tmp" -exec rm {} \;
find . -mtime +30 -delete           # Delete files older than 30 days

##################################################
# 12. PROCESS FILES LINE-BY-LINE
##################################################
while IFS= read -r line; do
    echo "$line"
done < filelist.txt

##################################################
# 13. EXTRACT FILENAME / EXTENSION / DIRECTORY
##################################################
filepath="images/photo.jpg"
filename=$(basename "$filepath")     # photo.jpg
name="${filename%.*}"               # photo
ext="${filename##*.}"               # jpg
dir=$(dirname "$filepath")          # images

##################################################
# 14. FILE EXISTENCE CHECKS
##################################################
[ -f file.txt ] && echo "File exists"
[ -d folder ] && echo "Directory exists"
[ ! -e file.txt ] && echo "File does not exist"

##################################################
# 15. HANDLE FILENAMES WITH SPACES
##################################################
for file in *; do
    echo "Processing: $file"
done

# or safely
find . -type f -print0 | while IFS= read -r -d '' file; do
    echo "Safe: $file"
done


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
