#!/bin/bash
#
# Script to generate TOC for each directory and sub-directory in the Obsidian Vault
#

# Change directory to Obsidian Vault
cd #<<INSERT DIRECTORY PATH HERE>>

# Function to create TOC for the directory
function createtoc() {
    echo "$1"
    for i in *; do
        if [[ "$i" == -* ]]; then
            :
        elif [[ -d "$i" ]]; then 
           echo "$i" >>  "$1"
        else 
            echo "[[$(basename "$i" .md)]]" >> "$1"
        fi
    done
}

function createmd() {
    # echo "$1" # debug
    cd "$1" 
    # echo "In ${PWD}" # debug
    filename="$(basename "$PWD") TOC"
    path="${PWD}/$filename.md"
    # echo $path # debug
    # echo " " # debug
    echo -e "# $filename\n***\n" > "$path"
    createtoc "$path"
    cd ..
}


export -f createmd
export -f createtoc
find . -type d -not -name "-*" -exec bash -c "createmd \"{}\"" \;
echo ""