#!/bin/sh
cd /scripts
apt-get update

apt-get install -y cmake=3.5.1-1ubuntu3
apt-get install -y autotools-dev=20150820.1
apt-get install -y libjpeg-dev=8c-2ubuntu8
apt-get install -y libgif-dev=5.1.4-0.3~16.04.1
apt-get install -y libxt-dev=1:1.1.5-0ubuntu1
apt-get install -y autoconf=2.69-9
apt-get install -y automake=1:1.15-4ubuntu1
apt-get install -y libtool=2.4.6-0.1
apt-get install -y bzip2=1.0.6-8ubuntu0.2
apt-get install -y libxml2-dev=2.9.3+dfsg1-1ubuntu0.7
apt-get install -y libuninameslist-dev=0.5.20150701-1
apt-get install -y libspiro-dev=1:0.5.20150702-4
apt-get install -y libpango1.0-dev=1.38.1-1
apt-get install -y libcairo2-dev=1.14.6-1
apt-get install -y chrpath=0.16-1
apt-get install -y uuid-dev=2.27.1-6ubuntu3.10
apt-get install -y uthash-dev=1.9.9.1+git20151125-1
apt-get install -y libltdl-dev
apt-get install -y build-essential

apt-get install -qq libpng12-dev
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