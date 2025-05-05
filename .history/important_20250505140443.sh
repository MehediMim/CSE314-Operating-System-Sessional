#file create
#file move
#file renaming
#directory recusrively traversal using find and while
#character or substring from string
#number from string
#parameter expansion
#cut
#tr
#grep
#basename


=============================
📁 FILE & DIRECTORY OPERATIONS
=============================

# Create a file
touch file.txt

# Create multiple files
touch file1.txt file2.txt file3.txt

# Move file(s)
mv file1.txt folder/

# Rename a file
mv oldname.txt newname.txt

# Copy file
cp source.txt destination.txt

# Delete file(s)
rm file.txt
rm *.log

# Delete directory and contents
rm -rf foldername

# Create directory
mkdir myfolder

# Create nested folders
mkdir -p parent/child/grandchild

# Move all `.txt` files to another folder
mv *.txt target_folder/

# Recursively copy directory
cp -r source_folder/ backup/

===========================
🔍 DIRECTORY TRAVERSAL
===========================

# Recursively list all files
find . -type f

# Find files with .sh extension
find . -type f -name "*.sh"

# Find and delete `.tmp` files
find . -name "*.tmp" -type f -delete

# While loop over all .txt files
find . -name "*.txt" | while read file; do
    echo "Processing $file"
done

======================
🧪 FILE TESTS
======================

[ -f file.txt ] && echo "File exists"
[ -d myfolder ] && echo "Directory exists"
[ ! -s file.txt ] && echo "File is empty"

===========================
🧵 STRING & TEXT MANIPULATION
===========================

# Substring
str="HelloWorld"
echo "${str:0:5}"     # Hello
echo "${str:5}"       # World
echo "${str: -3:2}"   # Output: rl

# Extract numbers
str="abc123xyz"
echo "$str" | grep -o -E '[0-9]+'  # 123
echo "$str" | grep -o -E '[0-9]+' | tail -n1  

# Extract file extension
filename="example.tar.gz"
echo "${filename##*.}"    # gz

# Get filename without extension
basename "${filename}" .gz

# Replace substring
echo "${str/World/Universe}"  # HelloUniverse

# Trim whitespace
str="  hello "
echo "$str" | xargs

====================
📄 CUT, TR, GREP
====================

# Extract second field
echo "name,email,phone" | cut -d',' -f2

# Translate characters (uppercase to lowercase)
echo "HELLO" | tr 'A-Z' 'a-z'

# Remove characters
echo "123-456-7890" | tr -d '-'

# Grep lines with pattern
grep "TODO" *.sh

# Count matches
grep -c "pattern" file.txt

====================
🔁 LOOPS
====================

# For loop over files
for file in *.txt; do
    echo "$file"
done

# While loop over file content
while read -r line; do
    echo "$line"
done < file.txt

===========================
📥 PARAMETERS & EXPANSION
===========================

# Default value if variable not set
echo "${username:-Guest}"

# Length of string
echo "${#str}"

# Remove suffix
echo "${filename%.txt}"  # strips .txt

# Remove prefix
echo "${path##*/}"       # basename
