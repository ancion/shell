#!/bin/bash

tar -xvf nvim-linux64.tar.gz
cd nvim-linux64
mv bin/nvim /usr/local/bin/nvim
if [ ! -d "/usr/local/lib/nvim/parser/" ]; then
    mkdir -p /usr/local/lib/nvim/parser/
fi
mv lib/nvim/parser/c.so  /usr/local/lib/nvim/parser/
mv share/applications/nvim.desktop /usr/share/applications/
if [ ! -d "/usr/local/share/nvim/site/autoload/" ]; then
    mkdir -p /usr/share/icons/hicolor/128x128/apps/
fi
mv share/icons/hicolor/128x128/apps/nvim.png /usr/share/icons/hicolor/128x128/apps/
mv share/man/man1/nvim.1 /usr/local/share/man/man1/
if [ -d "/usr/local/share/nvim" ]; then
    rm -rf /usr/local/share/nvim
fi
mv share/nvim /usr/local/share/

