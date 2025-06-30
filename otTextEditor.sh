#!/bin/bash

cmd=$1
file=$2

addLineTop() {
  echo "$3" | cat - "$file" > temp && mv temp "$file"
}

addLineBottom() {
  echo "$3" >> "$file"
}

addLineAt() {
  line_num=$3
  text=$4
  awk -v n="$line_num" -v l="$text" 'NR==n{print l} 1' "$file" > temp && mv temp "$file"
}

updateFirstWord() {
  sed -i "0,/$3/{s/$3/$4/}" "$file"
}

updateAllWords() {
  sed -i "s/$3/$4/g" "$file"
}

insertWord() {
  word1=$3
  word2=$4
  new_word=$5
  awk -v w1="$word1" -v w2="$word2" -v ins="$new_word" '{
    for(i=1;i<=NF;i++) {
      if($i==w1 && $(i+1)==w2) {
        printf("%s %s %s ", $i, ins, $(i+1)); i++
      } else {
        printf("%s ", $i)
      }
    }
    print ""
  }' "$file" > temp && mv temp "$file"
}

deleteLine() {
  if [ -n "$4" ]; then
    grep -v "$4" "$file" > temp && mv temp "$file"
  else
    sed -i "${3}d" "$file"
  fi
}

case $cmd in
  addLineTop) addLineTop "$@" ;;
  addLineBottom) addLineBottom "$@" ;;
  addLineAt) addLineAt "$@" ;;
  updateFirstWord) updateFirstWord "$@" ;;
  updateAllWords) updateAllWords "$@" ;;
  insertWord) insertWord "$@" ;;
  deleteLine) deleteLine "$@" ;;
  *)
    echo "Invalid command"
    ;;
esac
