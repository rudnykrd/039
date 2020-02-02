#!/bin/bash

mkdir -p $2 $2/$(date +%Y%m%d)
find $1 -mindepth 1 -mtime -1 -exec cp -r {} $2/$(date +%Y%m%d) \;