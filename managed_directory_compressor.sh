#!/bin/bash
# This script zips a directory, excluding specified files, types and subdirectories.
#  while zipping the directory it excludes hidden directories and certain file types

[[ "`/usr/bin/tty`" == "not a tty" ]] && . ~/.bash_profile

DIRECTORY=$(cd `dirname $0` && pwd)

if [[ -z $1 ]]; then
  echo "Usage: managed_directory_compressor /your-directory/ zip-file-name"
else
  directory=$1
  theme="$2.zip"
  zip -r "$theme" "$directory" ./ -x "*/\.*" -x "\.*" -x "*.zip" -x "*.csv" -x "*.rb" -x "*.bak" -x "*.swp" -x "*.back" -x "*.merge" -x "*.txt" -x "*.sh" -x "node_modules" -x "bower_components" -x "dist"

  echo "Your zip file, $theme is ready."
fi 
