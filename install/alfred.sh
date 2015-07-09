#!/bin/sh

# force sync local dir
localPreferences="$BASEDIR"/alfred/Alfred.alfredpreferences/preferences/local/*
commonLocalPreferences="$BASEDIR"/alfred/commonLocalPreferences

for localPreference in ${localPreferences}
do
  rm -rf $localPreference
  ln -snf $commonLocalPreferences $localPreference
done
