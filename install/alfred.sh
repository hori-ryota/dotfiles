#!/bin/sh

# force sync local dir
localPreferences="$BASEDIR"/alfred/Alfred.alfredpreferences/preferences/local/*
commonLocalPreferences=`find "$BASEDIR"/alfred/commonLocalPreferences -name *.plist`

for localPreference in ${localPreferences}
do
  for commonLocalPreference in ${commonLocalPreferences}
  do
    targetFile=$localPreference${commonLocalPreference#*/commonLocalPreferences}
    mkdir -p ${targetFile%/*}
    rm -rf $targetFile
    ln -nf $commonLocalPreference $targetFile
  done
done
