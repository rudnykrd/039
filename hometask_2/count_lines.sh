#!/bin/bash

wget -nc http://yoko.ukrtux.com:8899/versions.txt
sort versions.txt | uniq -c | sort -g | tail -n 1