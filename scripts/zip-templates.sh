#!/bin/sh

#VERSION=2.1.4-stable
VERSION=3.0.2-stable
GDVERSION=$(echo ${VERSION} | tr '-' '.')
#BUILD=1
DATE=$(date +%Y%m%d)
#VERSION=2.1.4-beta_${DATE}

echo ${GDVERSION} > templates/version.txt
zip -q -9 zip/Godot_v${VERSION}${BUILD}_export_templates.tpz templates/*
