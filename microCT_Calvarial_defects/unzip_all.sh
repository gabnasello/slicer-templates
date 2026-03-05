#!/bin/bash
# chmod +x unzip_all.sh
# Usage:
#   ./unzip_all.sh "Gomez 5p2-20250829T092357Z-1"
#   ./unzip_all.sh "Gomez 5p2-20250829T092357Z-1-00"

if [ -z "$1" ]; then
    echo "❌ Error: Missing argument."
    echo "Usage: $0 <basename>"
    echo "Examples:"
    echo "  $0 \"Gomez 5p2-20250829T092357Z-1\""
    echo "  $0 \"Gomez 5p2-20250829T092357Z-1-00\""
    exit 1
fi

BASENAME="$1"

# If user passed a trailing "-00", strip it
if [[ "$BASENAME" =~ -00$ ]]; then
    BASENAME="${BASENAME%-00}"
fi

echo "🔎 Looking for zip files with basename: $BASENAME"

FILES=( "$BASENAME"-[0-9][0-9][0-9].zip )

if [ ! -e "${FILES[0]}" ]; then
    echo "❌ No zip files found for basename '$BASENAME'"
    exit 1
fi

for zipfile in "${FILES[@]}"; do
    echo "📂 Unzipping: $zipfile"
    unzip -o "$zipfile" -d .
    if [ $? -eq 0 ]; then
        echo "✅ Successfully extracted: $zipfile"
    else
        echo "⚠️ Failed to extract: $zipfile"
    fi
done

echo "🎉 Done!"
