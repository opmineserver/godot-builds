#!/bin/sh

if [ ! -d angle ]; then
  wget -c https://github.com/GodotBuilder/godot-builds/releases/download/_tools/angle.7z
  p7zip -d angle.7z
fi

rm -rf uwp_template_*
rm -rf templates/uwp_*.zip

for arch in ARM Win32 x64; do
  cp -r godot/misc/dist/uwp_template uwp_template_${arch}

  cp angle/winrt/10/src/Release_${arch}/libEGL.dll \
     angle/winrt/10/src/Release_${arch}/libGLESv2.dll \
     uwp_template_${arch}/
  cp -r uwp_template_${arch} uwp_template_${arch}_debug
done

# ARM
cp bin/godot.uwp.opt.32.arm.exe uwp_template_ARM/godot.uwp.exe
cp bin/godot.uwp.opt.debug.32.arm.exe uwp_template_ARM_debug/godot.uwp.exe
cd uwp_template_ARM && zip -q -9 -r ../templates/uwp_arm_release.zip * && cd ..
cd uwp_template_ARM_debug && zip -q -9 -r ../templates/uwp_arm_debug.zip * && cd ..

# Win32
cp bin/godot.uwp.opt.32.x86.exe uwp_template_Win32/godot.uwp.exe
cp bin/godot.uwp.opt.debug.32.x86.exe uwp_template_Win32_debug/godot.uwp.exe
cd uwp_template_Win32 && zip -q -9 -r ../templates/uwp_x86_release.zip * && cd ..
cd uwp_template_Win32_debug && zip -q -9 -r ../templates/uwp_x86_debug.zip * && cd ..

# x64
cp bin/godot.uwp.opt.64.x64.exe uwp_template_x64/godot.uwp.exe
cp bin/godot.uwp.opt.debug.64.x64.exe uwp_template_x64_debug/godot.uwp.exe
cd uwp_template_x64 && zip -q -9 -r ../templates/uwp_x64_release.zip * && cd ..
cd uwp_template_x64_debug && zip -q -9 -r ../templates/uwp_x64_debug.zip * && cd ..

rm -rf uwp_template_*
