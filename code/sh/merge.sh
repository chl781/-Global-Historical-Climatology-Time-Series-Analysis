#!/bin/bash

rm -f all.csv
rm -f best50.csv
 
awk 'FNR > 1' outCA*.csv  > all.csv
awk 'FNR > 1' outCH*.csv  >> all.csv
awk 'FNR > 1' outUK*.csv >> all.csv
awk 'FNR > 1' outUS*.csv >> all.csv
echo '"names","aic"' > best50.csv
cat all.csv | sort -t',' -k 2n | head -n 50 >> best50.csv
