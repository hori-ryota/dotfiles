#!/bin/bash
java -jar $HOME/lib/java/plantuml.jar -tpng $@
# open ${@%.*}.png
