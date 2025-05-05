
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

