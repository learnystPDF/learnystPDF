learnystPDF
===========

Light weight PDF reader


## About this app

Light weight customized PDF reader based on muPDF(http://www.mupdf.com/).

## For Developers

Just trigger the light weight PDF feader with an intent along with PDF URL

## License
learnystPDF Reader is free software: you can redistribute it and/or modify it under the terms of the Affero GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This project is Copyright 2012-2014 Learnyst, except included libraries:
- Copyright 2006-2013 Artifex Software, Inc for the MuPDF library

The use of the Google Analytics library is governed by the following terms: http://www.google.com/analytics/tos.html


## Source code of libraries used
- MuPDF: git://git.ghostscript.com/mupdf.git

## How to build LearnystPdf for Android
Set up an Android build environment

Download and install the Android SDK. Run the android tool to install the platform tools. Add the tools and platform-tools directories inside the SDK directory to your PATH.

Download and install the Android NDK. Add the NDK directory to your PATH.

Make sure you have both JDK and ANT installed.

You will also need git and a regular development environment (gcc and gnu make).
Prepare the source

Check out a copy of the mupdf source from git:

~/src $ git clone git://git.ghostscript.com/mupdf.git

Check out the third party library submodules:

~/src/mupdf $ git submodule update --init

Populate the generated directory with the necessary files:

~/src/mupdf $ make generate

Build and debug

Change into the platform/android directory and edit the local properties configuration file.

~/src/mupdf $ cd platform/android
~/src/mupdf/platform/android $ cp local.properties.sample local.properties
~/src/mupdf/platform/android $ nano local.properties

Build the native code libraries:

~/src/mupdf/platform/android $ ndk-build

Build the java application:

~/src/mupdf/platform/android $ ant debug

Install the app on the device or emulator:

~/src/mupdf/platform/android $ ant debug install

Copy some files onto the device for the app to read:

~/src/mupdf/platform/android $ adb push .../file.pdf /mnt/sdcard/Download/file.pdf

To see debug messages from the emulator:

~/src/mupdf/platform/android $ adb logcat

Good luck!
MuPDF is Copyright 2006-2014 Artifex Software, Inc.
