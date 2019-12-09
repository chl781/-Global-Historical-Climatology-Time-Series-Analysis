#!/bin/bash
wget https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/ghcnd-stations.txt
cat ghcnd-stations.txt | cut -c 1-11 | grep CA.* > ghc1.txt
cat ghcnd-stations.txt | cut -c 1-11 | grep CH.* >> ghc1.txt
cat ghcnd-stations.txt | cut -c 1-11 | grep UK.* >> ghc1.txt
cat ghcnd-stations.txt | cut -c 1-11 | grep US.* >> ghc1.txt
