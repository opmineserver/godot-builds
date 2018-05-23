## Script for packaging official binaries

Those are the scripts used to package official binaries for Godot, after
building them on Travis CI and AppVeyor using the godot-builds repository:
https://github.com/GodotBuilder/godot-builds

Each script has some variables defined at the top that may need to be
adjusted to refer to the proper branch (2.1 or master or a specific commit),
or tag of the godot-builds repo. This could very well be improved, it's
quite hackish.

### Howto

Basically, run the scripts in this order to get most binaries prepared (but
Android):
- download-binaries.sh (set `VERSION`)
- prepare-binaries.sh (set `VERSION` and `BRANCH`)
- pack-uwp.sh 

Then do the same for Android; it's split from the main scripts because it
requires a build environment with the SDK and NDK which we don't have on
the current server, so I do those builds locally. We only get the libs
from Travis and not the full APK (could be improved too). So:
- download-binaries-android.sh (set `VERSION`)
- prepare-android.sh: for this one you need build.gradle and
  AndroidManifest.xml corresponding to `BRANCH` in the $(pwd). You can run
  a first build manually to get them generated from the template and then
  copy them over.
- move APKs from templates-android/ to templates/

Finally, it should be ready to package the templates:
- zip-templates.sh (set `VERSION`, and `BUILD` if relevant for alpha/beta/rc)
