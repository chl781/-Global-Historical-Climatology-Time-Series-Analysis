#!/bin/bash

rm -f allsort.csv
 
echo '"index","names","aic"' > allsort.csv
cat all.csv | sort -t',' -k 3n  >> allsort.csv
