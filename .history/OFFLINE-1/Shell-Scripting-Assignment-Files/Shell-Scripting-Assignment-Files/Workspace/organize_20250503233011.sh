#!/bin/bash

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

        if [ "$nolc" = true ] 
        then
            linecount=$(wc -l < "$file")
            # echo "Line Count : $linecount"
        fi

        if [ "$nocc" = true ] 
        then
            case "$extension" in
                py)
                    commentCount=$(grep -cE '#' "$file")
                ;; 
                cpp|c|java)
                    commentCount=$(grep -c '//' "$file")
                ;; 
                *)
                    commentCount=0
                ;;
            esac
        # echo "Comment Count : $commentCount"
        fi
        export linecount commentCount
    fi
}
organize_files(){
    unzipped_file="$1"
    targetFolder="$2"
    testFolder="$3"
    answerFolder="$4"
    unzippedFolderName="unzippedTrashBin"

    rm -rf "$unzippedFolderName"
    mkdir "$unzippedFolderName"
    unzip -q "$unzipped_file" -d "$unzippedFolderName"

    # echo "unzipped"
    code=$(get_file_path "$unzippedFolderName")
    if [ -z "$code" ]
    then
        echo "No such file was found"
        return
    fi
        
    studentID=$(extract_ids "$1")
    [ "$verbose" = true ] && echo "Organizing $studentID" 
    studentName=$(basename "$1" | cut -d'_' -f1-2 | tr '_' ' ')
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
            name="Main.java"
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

    linecount=""; 
    commentCount=""; 
    functionCount=""

    if [ "$nolc" = true ] || [ "$nocc" = true ] ||[ "$nofc" = true ]
    then
        analyze "$targetFolder/$destinationFolder/$name"
    fi

    matchCount=0
    notMatchCount=0

    if [ "$noexecute" = true ]; then
    result=$(runCode "$targetFolder/$destinationFolder/$name" "$testFolder" "$answerFolder" "$targetFolder/$destinationFolder")
    matchCount=$(echo "$result" | cut -d' ' -f1)
    notMatchCount=$(echo "$result" | cut -d' ' -f2)
    fi

    row_list=("$studentID" "$studentName" "$lang" "$matchCount" "$notMatchCount")


    [ "$nolc" = true ] && row_list+=("$linecount")
    [ "$nocc" = true ] && row_list+=("$commentCount")
    [ "$nofc" = true ] && row_list+=("$functionCount")


    row=$(IFS=, ; echo "${row_list[*]}")
    echo "$row" >> "$csv_file"
}
runCode(){
    code="$1"
    testFolder="$2"
    answerFolder="$3"
    destinationFolder="$4"

    extension=$(extract_extension "$code")

    matchCount=0
    notMatchCount=0


    case "$extension" in
        py)
            for test in "$testFolder"/test*.txt
            do
                testname=$(basename "$test")
                id=$(echo "$testname" | grep -o -E '[0-9]+')
                output="$destinationFolder/out${id}.txt"

                python3 "$code" < "$test" > "$output"

                if diff -q "$output" "$answerFolder/ans${id}.txt" > /dev/null; then
                    matchCount=$((matchCount + 1))
                else
                    notMatchCount=$((notMatchCount + 1))
                fi

            done
        ;;
        c)
            gcc "$code" -o "$destinationFolder/main.out" 
            if [ $? -ne 0 ]
            then
                echo "Compilation Error"
                return
            fi

            for test in "$testFolder"/test*.txt
            do
                testname=$(basename "$test")
                id=$(echo "$testname" | grep -o -E '[0-9]+')
                output="$destinationFolder/out${id}.txt"
                "$destinationFolder/main.out" < "$test" > "$output"

                if diff -q "$output" "$answerFolder/ans${id}.txt" > /dev/null; then
                    matchCount=$((matchCount + 1))
                else
                    notMatchCount=$((notMatchCount + 1))
                fi
            done
        ;;
        cpp)
            g++ "$code" -o "$destinationFolder/main.out" 
            if [ $? -ne 0 ]
            then
                echo "Compilation Error"
                return
            fi

            for test in "$testFolder"/test*.txt
            do
                testname=$(basename "$test")
                id=$(echo "$testname" | grep -o -E '[0-9]+')
                output="$destinationFolder/out${id}.txt"
                "$destinationFolder/main.out" < "$test" > "$output"

                if diff -q "$output" "$answerFolder/ans${id}.txt" > /dev/null; then
                    matchCount=$((matchCount + 1))
                else
                    notMatchCount=$((notMatchCount + 1))
                fi
            done

        ;;
        java)
            javac "$code" -d "$destinationFolder"
            if [ $? -ne 0 ]
            then
                echo "Compilation Error"
                return
            fi

            for test in "$testFolder"/test*.txt
            do
                testname=$(basename "$test")
                id=$(echo "$testname" | grep -o -E '[0-9]+')
                output="$destinationFolder/out${id}.txt"
                java -cp "$destinationFolder" Main < "$test" > "$output"

                if diff -q "$output" "$answerFolder/ans${id}.txt" > /dev/null; then
                    matchCount=$((matchCount + 1))
                else
                    notMatchCount=$((notMatchCount + 1))
                fi

            done

        ;;
    esac
    echo "$matchCount $notMatchCount"
    export matchCount
    export notMatchCount
    # export matchCount notMatchCount
    # return 0
    # export runCode_matchCount=$matchCount
    # export runCode_notMatchCount=$notMatchCount

}


main(){

    submissionFolder="$1"
    targetFolder="$2"
    testFolder="$3"
    answerFolder="$4"

    if [ "$#" -lt 4 ]; then
        echo "Usage: $0 <submissions> <target> <test> <answers> [options]"
        exit 1
    fi
    shift 4

    verbose=false
    noexecute=true
    nolc=true
    nocc=true
    nofc=true



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
        esac
    done

    mkdir -p "$targetFolder"

    csv_file="$targetFolder/result.csv"
    header_list=("student_id" "student_name" "language" "matched" "not_matched")
    [ "$nolc" = true ] && header_list+=("line_count")
    [ "$nocc" = true ] && header_list+=("comment_count")
    [ "$nofc" = true ] && header_list+=("function_count")
    header=$(IFS=, ; echo "${header_list[*]}")
    echo "$header" > "$csv_file"


    for i in "$submissionFolder/"*.zip
    do
        organize_files "$i" "$targetFolder" "$testFolder" "$answerFolder"
    done
    rm -rf "$unzippedFolderName"
}


main "$@"