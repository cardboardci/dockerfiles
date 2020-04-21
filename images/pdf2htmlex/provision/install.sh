#!/bin/sh
apt-get update

apt-get install -qq libtiff4-dev libpng12-dev
git clone https://github.com/coolwanglu/fontforge.git fontforge.git

cd fontforge.git
git checkout pdf2htmlEX
./autogen.sh
./configure
make V=1
make install
apt-get install -qq libpoppler-glib-dev
echo "Cleaning up"
rm -rf var/cache/archives/*
git clone https://github.com/coolwanglu/pdf2htmlEX.git

cd pdf2htmlEX
cmake .
make
make install

mkdir /src