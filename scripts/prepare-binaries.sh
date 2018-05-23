#!/bin/bash
# This script is intended to run on Linux or OSX. Cygwin might work.
# It should be run from within the root directory of Godot


#VERSION=v2.1.4-stable
VERSION=v3.0.2-stable
DATE=$(date +%Y%m%d)
#BASENAME="Godot_${VERSION}_${DATE}"
BASENAME="Godot_${VERSION}"
#BRANCH=master
BRANCH=3.0

#export ANDROID_HOME=/home/akien/Projects/godot/android-sdk-linux


#######################
# PREPARE ENVIRONMENT #
#######################

if [ ! -d "bin" ]; then
  echo "Run this script from the folder which contains the 'bin' folder."
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
git pull --rebase
cd ..

for file in $(cat binary_list.txt); do
  if [ ! -e "bin/$file" ]; then
    echo "The file $file is missing, some steps may fail."
  fi
done


# Prepare directories for tools binaries and templates
rm -rf templates tools zip
mkdir -p templates tools zip


#######################
# PACK TOOLS BINARIES #
#######################

cd $ROOTDIR/tools

# Linux X11 and server
cp ../bin/godot.x11.opt.tools.32 ${BASENAME}_x11.32
cp ../bin/godot.x11.opt.tools.64 ${BASENAME}_x11.64
cp ../bin/godot_server.server.opt.tools.64 ${BASENAME}_linux_server.64

# Windows
cp ../bin/godot.windows.opt.tools.32.exe ${BASENAME}_win32.exe
cp ../bin/godot.windows.opt.tools.64.exe ${BASENAME}_win64.exe

for file in $(ls); do
  chmod +x $file
  zip -q -9 "../zip/$file.zip" $file
done

# OSX, needs some custom packing
cp -r ../godot/misc/dist/osx_tools.app Godot.app
mkdir -p Godot.app/Contents/MacOS
cp ../bin/godot.osx.opt.tools.* Godot.app/Contents/MacOS/Godot
chmod +x Godot.app/Contents/MacOS/Godot
zip -q -9 -r "../zip/${BASENAME}_osx.fat.zip" Godot.app
rm -rf Godot.app

#####################
# PREPARE TEMPLATES #
#####################

cd $ROOTDIR/templates

# Linux X11
cp ../bin/godot.x11.opt.32 linux_x11_32_release
cp ../bin/godot.x11.opt.debug.32 linux_x11_32_debug
cp ../bin/godot.x11.opt.64 linux_x11_64_release
cp ../bin/godot.x11.opt.debug.64 linux_x11_64_debug
chmod +x linux_x11*

# Windows
cp ../bin/godot.windows.opt.32.exe windows_32_release.exe
cp ../bin/godot.windows.opt.debug.32.exe windows_32_debug.exe
cp ../bin/godot.windows.opt.64.exe windows_64_release.exe
cp ../bin/godot.windows.opt.debug.64.exe windows_64_debug.exe
chmod +x windows*

# OSX
cp -r ../godot/misc/dist/osx_template.app .
mkdir osx_template.app/Contents/MacOS
cp ../bin/godot.osx.opt.fat osx_template.app/Contents/MacOS/godot_osx_release.fat
cp ../bin/godot.osx.opt.debug.fat osx_template.app/Contents/MacOS/godot_osx_debug.fat
chmod +x osx_template.app/Contents/MacOS/godot_osx*
zip -q -9 -r osx.zip osx_template.app
rm -rf osx_template.app

# iOS
cp -r ../godot/misc/dist/ios_xcode ios_xcode
cp ../bin/libgodot.iphone.opt.fat ios_xcode/libgodot.iphone.release.fat.a
cp ../bin/libgodot.iphone.opt.debug.fat ios_xcode/libgodot.iphone.debug.fat.a
chmod +x ios_xcode/libgodot.iphone.*
cd ios_xcode
zip -q -9 -r ../iphone.zip *
cd ..
rm -rf ios_xcode

# HTML5
cp ../bin/godot.javascript.opt.zip webassembly_release.zip
cp ../bin/godot.javascript.opt.debug.zip webassembly_debug.zip

# Android (needs building with gradle)
#cd $ROOTDIR
#mkdir -p godot/platform/android/java/libs/{armeabi,x86}
#cp -f build.gradle AndroidManifest.xml godot/platform/android/java

#cp -f bin/libgodot.android.opt.armv7.neon.dylib godot/platform/android/java/libs/armeabi/libgodot_android.so
#cp -f bin/libgodot.android.opt.x86.dylib godot/platform/android/java/libs/x86/libgodot_android.so
#cd godot/platform/android/java
#./gradlew build
#cp build/outputs/apk/java-release-unsigned.apk $ROOTDIR/templates/android_release.apk

#cd $ROOTDIR
#cp -f bin/libgodot.android.opt.debug.armv7.neon.dylib godot/platform/android/java/libs/armeabi/libgodot_android.so
#cp -f bin/libgodot.android.opt.debug.x86.dylib godot/platform/android/java/libs/x86/libgodot_android.so
#cd godot/platform/android/java
#./gradlew build
#cp build/outputs/apk/java-release-unsigned.apk $ROOTDIR/templates/android_debug.apk


############################
# PACK TEMPLATES AND STUFF #
############################

cd $ROOTDIR

# Create the template package
#zip -q -9 zip/${BASENAME}_export_templates.tpz templates/*

# Pack the demos
#cp -r godot/demos ${BASENAME}_demos
#zip -q -9 -r zip/${BASENAME}_demos.zip ${BASENAME}_demos

# Better Collada Exporter
#cd godot/tools/export/blender25
#zip -q -9 -r ${ROOTDIR}/zip/${BASENAME}_better_collada.zip install.txt io_scene_dae
