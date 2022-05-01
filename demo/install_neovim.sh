#!/bin/bash

tar -xvf nvim-linux64.tar.gz
cd nvim-linux64
mv bin/nvim /usr/local/bin/nvim
mv lib/nvim/parser/c.so  /usr/local/lib/nvim/parser/
mv share/applications/nvim.desktop /usr/share/applications/
mv share/icons/hicolor/128x128/apps/nvim.png /usr/share/icons/hicolor/128x128/apps/
mv share/man/man1/nvim.1 /usr/local/share/man/man1/
rm -rf /usr/local/share/nvim/
mv share/nvim /usr/local/share/

