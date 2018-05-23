# Godot builds via Travis and AppVeyor

This repo is used to trigger automatic builds of all official templates
and editor binaries for [Godot Engine](https://godotengine.org).

Those binaries are deployed to GitHub Releases by Travis and AppVeyor,
and then post-processed on a separate server to generate the Android APK,
pack the OSX and iOS archives, and zip it all with the proper names.

See the [Releases](https://github.com/GodotBuilder/godot-builds/releases)
page for the latest builds.

[![Travis status](https://travis-ci.org/GodotBuilder/godot-builds.svg?branch=master)](https://travis-ci.org/GodotBuilder/godot-builds)
[![AppVeyor status](https://ci.appveyor.com/api/projects/status/gld0ahapgjt0vrbg?svg=true)](https://ci.appveyor.com/project/GodotBuilder/godot-builds)
