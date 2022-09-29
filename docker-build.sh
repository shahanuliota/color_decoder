#!/bin/bash

echo "================================"

d=$(date +%F)
h=$(date +%H)
m=$(date +%M)
echo $d-$h-$m > tag_id.txt
tag=$(cat tag_id.txt)
docker build -t shawon1fb/color-decoder:$tag -t shawon1fb/color-decoder:latest .
echo "================================"