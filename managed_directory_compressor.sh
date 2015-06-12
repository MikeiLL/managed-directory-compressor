#!/bin/bash
# This script zips a directory, excluding specified files, types and subdirectories.
#  while zipping the directory it excludes hidden directories and certain file types

[[ "`/usr/bin/tty`" == "not a tty" ]] && . ~/.bash_profile

DIRECTORY=$(cd `dirname $0` && pwd)

if [[ -z $1 ]]; then
  echo "Usage: managed_directory_compressor /your-directory/ zip-file-name"
else
  DIRECTORY_TO_COMPRESS=${1%/}
  ZIPPED_FILE="$2.zip"

  COMPRESS_IGNORE_FILE=("\.git" "*.zip" "*.csv" "*.json" "gulpfile.js" "*.rb" "*.bak" "*.swp" "*.back" "*.merge" "*.txt" "*.sh" "bower_components" "node_modules") 
  COMPRESS_IGNORE_DIR=("bower_components" "node_modules")

  IGNORE_LIST=("*/\.*" "\.* "\/\.*"")
  if [[ -n $COMPRESS_IGNORE_FILE ]]; then
      for IGNORE_FILES in "${COMPRESS_IGNORE_FILE[@]}"; do
          IGNORE_LIST+=("$DIRECTORY_TO_COMPRESS/$IGNORE_FILES/*")  
      done
      for IGNORE_DIR in "${COMPRESS_IGNORE_DIR[@]}"; do
          IGNORE_LIST+=("$DIRECTORY_TO_COMPRESS/$IGNORE_DIR/")
      done
  fi

  zip -r "$ZIPPED_FILE" "$DIRECTORY_TO_COMPRESS" -x "${IGNORE_LIST[@]}" # >/dev/null
  # echo zip -r "$ZIPPED_FILE" "$DIRECTORY_TO_COMPRESS" -x "${IGNORE_LIST[@]}" # >/dev/null
  echo $DIRECTORY_TO_COMPRESS "compressed as" $ZIPPED_FILE.
fi
