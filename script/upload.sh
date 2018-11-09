#!/bin/sh
DIR=$(dirname "$0")

FIXED_BRANCH=$(echo $BRANCH | sed 's/\//-/g')
FILE_DIR=$DIR/../out
FILE=$FILE_DIR/document.pdf
DEST_FILE=$FILE_DIR/${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}-$(date +%Y-%m-%d_%H_%M_%S)-$TRAVIS_COMMIT.pdf

echo "Copying $FILE to $DEST_FILE"

mv $FILE $DEST_FILE

echo "Start Google Drive upload (file name: $DEST_FILE)"
./bin/gdrive-linux-x64 upload --refresh-token $GDRIVE_REFRESH_TOKEN --parent $GDRIVE_DIR $DEST_FILE
echo "Finished Google Drive upload"