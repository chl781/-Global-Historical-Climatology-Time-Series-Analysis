#!/bin/bash

rm -f data
mkdir data
cat ./ghc1.txt | {
    while read n;do
        wget https://www.ncei.noaa.gov/data/global-historical-climatology-network-daily/access/$n.csv $n.csv 
     done
}

