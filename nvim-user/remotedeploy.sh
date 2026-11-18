#!/bin/sh

BASEURL="https://raw.githubusercontent.com/drcrane/configs/refs/heads/master/nvim-user/"
DOWNLOAD_DIR="download/"

export BASEURL DOWNLOAD_DIR

# Temporary file for the file list
FILELIST=$(mktemp) || exit 1
trap 'rm -f "$FILELIST"' EXIT HUP INT TERM

echo "Fetching file list..."

if ! curl -fsSL "${BASEURL}FILES.txt" -o "$FILELIST"; then
    echo "ERROR: Failed to download FILES.txt" >&2
    exit 1
fi

while IFS= read -r FILE || [ -n "$FILE" ]; do
    # Skip blank lines and comments
    case "$FILE" in
        ''|\#*) continue ;;
    esac

    # Reject absolute paths and directory traversal
    case "/$FILE/" in
        *"/../"*|//*)
            echo "Skipping unsafe path: $FILE" >&2
            continue
            ;;
    esac

    case "$FILE" in
        /*)
            echo "Skipping absolute path: $FILE" >&2
            continue
            ;;
    esac

    DEST="${DOWNLOAD_DIR}$FILE"
    URL="${BASEURL}$FILE"

    # Create destination directory
    DIR=$(dirname "$DEST")
    mkdir -p "$DIR" || {
        echo "ERROR: Cannot create directory: $DIR" >&2
        continue
    }

    echo "Downloading: $FILE"

    if curl -fsSL "$URL" -o "$DEST"; then
        echo "  OK: $DEST"
    else
        echo "  FAILED: $FILE" >&2
        rm -f "$DEST"
    fi

done < "$FILELIST"

echo "Download complete."

