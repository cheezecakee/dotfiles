#!/usr/bin/env bash
set -e

if [ "$1" = "." ] && [ -n "$2" ]; then
    git add .
    git commit -m "$2"
    git push
    echo "Committed & pushed: $2"
    exit 0
fi

while true; do
    echo
    echo "Changed files:"
    mapfile -t FILE_LIST < <(git status --porcelain | awk '{print $2}')

    if [ ${#FILE_LIST[@]} -eq 0 ]; then
        echo "No changes detected."
    else
        for i in "${!FILE_LIST[@]}"; do
            printf "%d) %s\n" $((i+1)) "${FILE_LIST[$i]}"
        done
    fi

    if [ -z "$1" ]; then
        echo
        echo "Enter file numbers OR filenames (space-separated) or '.' for all:"
        echo -n "> "
        read -r INPUT

        if [ "$INPUT" = "." ]; then
            FILES="."
        else
            FILES=""
            for token in $INPUT; do
                if [[ "$token" =~ ^[0-9]+$ ]] && [ "$token" -le "${#FILE_LIST[@]}" ]; then
                    FILES="$FILES ${FILE_LIST[$((token-1))]}"
                                else
                    FILES="$FILES $token"
                fi
            done
        fi
    else
        FILES="$1"
        set --
    fi

    if [ "$FILES" != "." ]; then
        for f in $FILES; do
            if [ ! -e "$f" ]; then
                echo "Error: file not found: $f"
                exit 1
            fi
        done
    fi

    echo
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

    git add $FILES
    git commit -m "$MESSAGE"

    echo
    echo "Committed: $MESSAGE"
    git log --oneline -5
    echo

    echo
    echo "Repository state:"

    UNSTAGED=$(git status --porcelain | awk '$1=="??" || $1==" M" {print $2}')
    STAGED=$(git diff --cached --name-only)

    if [ -n "$UNSTAGED" ]; then
        echo
        echo "Unstaged:"
        i=1
        while IFS= read -r f; do
            [ -z "$f" ] && continue
            echo "$i) $f"
            i=$((i+1))
        done <<< "$UNSTAGED"
    fi

    if [ -n "$STAGED" ]; then
        echo
        echo "Staged:"
        while IFS= read -r f; do
            [ -z "$f" ] && continue
            echo "✓ $f"
        done <<< "$STAGED"
    fi

    echo

    echo "Next action:"
    echo "c) commit another"
    echo "p) push"
    echo "q) quit"
    echo -n "> "
    read -r NEXT

    case "$NEXT" in
        c)
            set --
            ;;
        p)
            git push
            echo "Pushed."
            exit 0
            ;;
        q)
            exit 0
            ;;
        *)
            exit 0
            ;;
    esac

done
