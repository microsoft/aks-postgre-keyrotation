#!/bin/bash

for filename in diagrams/*; do
    ./node_modules/.bin/mmdc -p puppeteer-config.json -c config.json -i $filename -o images/$(basename $filename .mmd).png
done