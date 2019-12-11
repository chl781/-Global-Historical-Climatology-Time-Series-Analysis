#!/bin/bash

rm -f all.csv
rm -f best50.csv
awk 'FNR > 1' outCA*.csv | grep [!Inf] > all.csv
awk 'FNR > 1' outCH*.csv | grep [!Inf] >> all.csv
awk 'FNR > 1' outUK*.csv | grep [!Inf]>> all.csv
awk 'FNR > 1' outUS*.csv | grep [!Inf]>> all.csv 

echo '"index","names","aic"' > best50.csv
cat all.csv | sort -t',' -k 3n | head -n 50 >> best50.csv
