#!/bin/bash

mkdir /tmp/motion
cd /tmp

git clone https://github.com/Mr-Dave/motion.git
cd motion
autoreconf -fiv
./configure
make
make install

cd /
rm -rf /tmp/* /var/tmp/*
