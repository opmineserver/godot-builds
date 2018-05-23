#!/bin/bash
# This script is intended to run on Linux or OSX. Cygwin might work.
# It should be run from within the root directory of Godot


#BRANCH=master
#BRANCH=3.0
BRANCH=2.1

export ANDROID_HOME=/media/data2/Dev/android-sdk-linux
export ANDROID_NDK_ROOT=/media/data2/Dev/android-ndk-r16b


#######################
# PREPARE ENVIRONMENT #
#######################

if [ ! -d "bin-android" ]; then
  echo "Run this script from the folder which contains the 'bin-android' folder."
  exit 1
fi

ROOTDIR=$(pwd)

if [ ! -d "godot" ]; then
  echo "No 'godot' repo in the tree, cloning it."
  git clone https://github.com/godotengine/godot godot
fi

cd godot
git fetch origin
git checkout $BRANCH
git pull --rebase origin $BRANCH
cd ..

for file in $(cat binary_list_android.txt); do
  if [ ! -e "bin-android/$file" ]; then
    echo "The file $file is missing, some steps may fail."
  fi
done


# Prepare directories for tools binaries and templates
rm -rf templates-android
mkdir -p templates-android



# Android (needs building with gradle)
cd $ROOTDIR
mkdir -p godot/platform/android/java/libs/{release,debug}/{armeabi-v7a,x86}
cp -f build.gradle AndroidManifest.xml godot/platform/android/java

cp -f bin-android/libgodot.android.opt.release.armeabi-v7a.so godot/platform/android/java/libs/release/armeabi-v7a/libgodot_android.so
cp -f bin-android/libgodot.android.opt.release.x86.so godot/platform/android/java/libs/release/x86/libgodot_android.so
cp -f bin-android/libgodot.android.opt.debug.armeabi-v7a.so godot/platform/android/java/libs/debug/armeabi-v7a/libgodot_android.so
cp -f bin-android/libgodot.android.opt.debug.x86.so godot/platform/android/java/libs/debug/x86/libgodot_android.so

cd godot/platform/android/java
./gradlew build

cp $ROOTDIR/godot/bin/android_release.apk $ROOTDIR/templates-android/
cp $ROOTDIR/godot/bin/android_debug.apk $ROOTDIR/templates-android/
