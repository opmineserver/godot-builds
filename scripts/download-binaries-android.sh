#!/bin/bash
# This script is intended to run on Linux or OSX. Cygwin might work.
# It should be run from within the root directory of Godot


if [ ! -e binary_list_android.txt ]; then
  echo "This script should be run from the folder that contains 'binary_list.txt'."
  exit 1
fi


REPO=https://github.com/GodotBuilder/godot-builds/releases/download
VERSION=3.0_20180303-1
#VERSION=3.0.1-stable

rm -rf bin-android
mkdir bin-android
cd bin-android


for file in $(cat ../binary_list_android.txt); do
  wget -c ${REPO}/${VERSION}/$file;
done
