#!/bin/bash
# This script zips a directory, excluding specified files, types and subdirectories.
#  while zipping the directory it excludes hidden directories and certain file types

[[ "`/usr/bin/tty`" == "not a tty" ]] && . ~/.bash_profile

DIRECTORY=$(cd `dirname $0` && pwd)

if [[ -z $1 ]]; then
  echo "Usage: managed_directory_compressor /your-directory/ zip-file-name"
else
  DIRECTORY_TO_COMPRESS=$1
  ZIPPED_FILE="$2.zip"

  COMPRESS_IGNORE_DIR=("\.git" "*.zip" "*.csv" "*.json" "gulpfile.js" "*.rb" "*.bak" "*.swp" "*.back" "*.merge" "*.txt" "*.sh" "node_modules" "bower_components")

  IGNORE_LIST=("*/\.*" "\.* "\/\.*"")
  if [[ -n $COMPRESS_IGNORE_DIR ]]; then
      for IGNORE_DIR in "${COMPRESS_IGNORE_DIR[@]}"; do
          IGNORE_LIST+=("$DIRECTORY_TO_COMPRESS/$IGNORE_DIR/***")  ## "$DIRECTORY_TO_COMPRESS/$IGNORE_DIR/*"  perhaps is enough?
      done
  fi

  zip -r "$ZIPPED_FILE" "$DIRECTORY_TO_COMPRESS" -x "${IGNORE_LIST[@]}" # >/dev/null
  echo zip -r "$ZIPPED_FILE" "$DIRECTORY_TO_COMPRESS" -x "${IGNORE_LIST[@]}" # >/dev/null
  echo "Done"
fi
