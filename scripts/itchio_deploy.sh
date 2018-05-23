VERSION=$1
if [ -z "$VERSION" ]; then
   echo "Pass a version string (e.g. '3.0.2-stable') as argument."
fi

butler push Godot_v${VERSION}_x11.64.zip godotengine/godot:linux-64-stable --userversion ${VERSION}
butler push Godot_v${VERSION}_x11.32.zip godotengine/godot:linux-32-stable --userversion ${VERSION}
butler push Godot_v${VERSION}_osx.fat.zip godotengine/godot:osx-fat-stable --userversion ${VERSION}
butler push Godot_v${VERSION}_win64.exe.zip godotengine/godot:windows-64-stable --userversion ${VERSION}
butler push Godot_v${VERSION}_win32.exe.zip godotengine/godot:windows-32-stable --userversion ${VERSION}
