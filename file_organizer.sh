#!/bin/bash
# File Organizer Script
# Organizes files in the current directory by their extensions

echo "Organizing files..."

for file in *; do
    if [ -f "$file" ]; then
        ext="${file##*.}"
        mkdir -p "$ext"
        mv "$file" "$ext/"
    fi
done

echo "Organization complete!"
