#!/bin/bash
set -e

DIST_DIR=$HOME"/PACKAGES"
PROJECT_NAME=android-spanglish-keyboard-layout

# Android signing
ANDROID_KEYSTORE=$HOME/Dropbox/docs/ids/rgarcia_android.keystore

echo -n "Version: "
read VERSION
echo

VERSION_CODE=$((`echo $VERSION | cut -d. -f1` * 100 + `echo $VERSION | cut -d. -f2`))

echo -n "Keystore Password: "
read -s KEYSTORE_PASSWD
echo
echo -n "Key Password: "
read -s KEY_PASSWD
echo

RELFILENAME="$DIST_DIR"/$PROJECT_NAME-$VERSION.apk

./gradlew -Pkeystore=$ANDROID_KEYSTORE -PstorePassword=$KEYSTORE_PASSWD -Palias=bladecoder -PkeyPassword=$KEY_PASSWD app:assembleRelease -Pversion=$VERSION  -PversionCode=$VERSION_CODE
cp app/build/outputs/apk/release/app-release.apk "$RELFILENAME"

echo -- RELEASE OK: $RELFILENAME --

