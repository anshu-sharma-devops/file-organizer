#!/bin/bash
# ==========================================
# Advanced File Organizer Script
# Author: Anshu Sharma (Whitedevil9103)
# ==========================================

LOG_FILE="organizer.log"
UNDO_FILE="undo.log"

echo "Starting File Organizer..."
echo "Log file: $LOG_FILE"

> "$LOG_FILE"
> "$UNDO_FILE"

undo() {
    echo "Restoring files..."
    while IFS= read -r line; do
        src=$(echo "$line" | cut -d '|' -f1)
        dest=$(echo "$line" | cut -d '|' -f2)
        mv "$dest" "$src"
        echo "Restored: $dest -> $src"
    done < "$UNDO_FILE"
    echo "Undo complete!"
    exit 0
}

if [[ $1 == "--undo" ]]; then
    undo
fi

for file in *; do
    if [[ -f "$file" && "$file" != "file_organizer.sh" && "$file" != "README.md" ]]; then
        ext="${file##*.}"
        mkdir -p "$ext"
        mv "$file" "$ext/"
        echo "Moved $file to $ext/" | tee -a "$LOG_FILE"
        echo "$(pwd)/$file|$(pwd)/$ext/$file" >> "$UNDO_FILE"
    fi
done

echo "Organization complete! Log saved in $LOG_FILE"
