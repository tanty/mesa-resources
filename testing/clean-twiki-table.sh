#!/bin/bash

if [ "x$1" = "x" ]; then
   echo "Syntax error"
   exit -1
fi

FILE=$(mktemp)

cat "$1" | grep FAIL > "$FILE"
cat "$1" | grep INTERNAL_ERROR >> "$FILE"
cat "$FILE" | sort | uniq | sort > "$1"

rm "$FILE"
