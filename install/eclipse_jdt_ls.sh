#!/bin/sh

set -eu

dst="$HOME"/eclipse.jdt.ls/

rm -rf $dst
mkdir -p $dst
curl http://download.eclipse.org/jdtls/snapshots/jdt-language-server-0.17.0-201804162308.tar.gz | tar xz -C $dst
