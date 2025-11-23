#!/usr/bin/env bash
set -e

# If user passed both files and commit message
if [ -n "$1" ] && [ -n "$2" ]; then
    FILES="$1"
    MESSAGE="$2"
else
    # Ask for files interactively
    if [ -z "$1" ]; then
        echo "Enter the files you want to stage (space-separated):"
        echo -n "> "
        read -r FILES
    else
        FILES="$1"
    fi

    # Ask for commit message if not provided
    if [ -z "$2" ]; then
        echo "Select commit type:"
        echo "1) feat"
        echo "2) fix"
        echo "3) docs"
        echo "4) style"
        echo "5) refactor"
        echo "6) chore"
        echo "7) perf"
        echo "8) test"
        echo -n "> "
        read -r TYPE_CHOICE

        case "$TYPE_CHOICE" in
            1) TYPE="feat" ;;
            2) TYPE="fix" ;;
            3) TYPE="docs" ;;
            4) TYPE="style" ;;
            5) TYPE="refactor" ;;
            6) TYPE="chore" ;;
            7) TYPE="perf" ;;
            8) TYPE="test" ;;
            *) echo "Invalid type"; exit 1 ;;
        esac

        echo -n "Commit message: "
        read -r MSG
        MESSAGE="$TYPE: $MSG"
    fi
fi

# Validate files exist
for f in $FILES; do
    if [ ! -e "$f" ]; then
        echo "Error: file not found: $f"
        exit 1
    fi
done

git add $FILES
git commit -m "$MESSAGE"
git push

echo "Committed & pushed: $MESSAGE"
