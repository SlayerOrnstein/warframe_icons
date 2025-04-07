#!/bin/bash

echo "starting the build process"

echo "get latest ttf"

# clone genesis-assets
git clone https://github.com/WFCD/genesis-assets.git

# move font and json
cp genesis-assets/fonts/Warframe-Symbols.ttf fonts/Warframe-Symbols.ttf

cd "fonts"

echo "get ttf xml"
ttx -t cmap Warframe-Symbols.ttf

echo "generating dart file"
dart "./tools/generate_font.dart"

echo "formatting dart files"
dart format "./lib/src/icon_data.g.dart"

rm -r "genesis-assets"

echo "build process done"