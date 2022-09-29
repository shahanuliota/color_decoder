#!/bin/bash

echo "================================"
tagname=$(cat tag_id.txt)
docker push shawon1fb/color-decoder:$tagname
docker push shawon1fb/color-decoder:latest
echo "================================"
