#!/usr/bin/env sh

git clone $1
if [ $1 ]; then
  IFS='/' read -a array <<< "$1"
  cd "${array[1]}"
  git fork
  git rr
fi
