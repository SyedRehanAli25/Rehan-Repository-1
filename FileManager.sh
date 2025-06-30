#!/bin/bash

case $1 in

  # Directory Operations
  addDir)
    mkdir -p "$2/$3"
    echo "Directory $3 created in $2"
    ;;
  
  deleteDir)
    rm -r "$2/$3"
    echo "Directory $3 deleted from $2"
    ;;

  listFiles)
    find "$2" -maxdepth 1 -type f
    ;;
  
  listDirs)
    find "$2" -maxdepth 1 -type d
    ;;
  
  listAll)
    ls -la "$2"
    ;;

  # File Operations
  addFile)
    if [ -n "$4" ]; then
      echo "$4" > "$2/$3"
    else
      touch "$2/$3"
    fi
    echo "File $3 created in $2"
    ;;
  
  addContentToFile)
    echo "$4" >> "$2/$3"
    echo "Content added to $3 in $2"
    ;;

  addContentToFileBegining)
    tmpfile=$(mktemp)
    echo "$4" > "$tmpfile"
    cat "$2/$3" >> "$tmpfile"
    mv "$tmpfile" "$2/$3"
    echo "Content added to beginning of $3 in $2"
    ;;

  showFileBeginingContent)
    head -n "$4" "$2/$3"
    ;;   

  showFileEndContent)
    tail -n "$4" "$2/$3"
    ;;
  
  showFileContentAtLine)
    awk "NR==$4" "$2/$3"
    ;;
  
  showFileContentForLineRange)
    awk "NR>=$4 && NR<=$5" "$2/$3"
    ;;
  
  moveFile)
    mv "$2" "$3"
    echo "Moved file from $2 to $3"
    ;;
  
  copyFile)
    cp "$2" "$3"
    echo "Copied file from $2 to $3"
    ;;
  
  clearFileContent)
    : > "$2/$3"
    echo "Cleared content of $3 in $2"
    ;;
  
  deleteFile)
    rm "$2/$3"
    echo "Deleted file $3 from $2"
    ;;

  *)
    echo "Invalid command"
    ;;
esac

