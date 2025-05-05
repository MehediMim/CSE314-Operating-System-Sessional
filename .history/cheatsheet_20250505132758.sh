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

