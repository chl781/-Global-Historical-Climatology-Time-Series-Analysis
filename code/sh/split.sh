#!/bin/bash                                                                    
nProcessors=10 
data="ghc1.txt"
nDataLines=$(wc -l < $data)
nLinesPerSplitFile=$(($nDataLines / $nProcessors))
remainder=$(($nDataLines % $nProcessors))
if [[ $remainder > 0 ]]; then
  nLinesPerSplitFile=$(($nLinesPerSplitFile + 1))
fi
split -d -l $nLinesPerSplitFile $data "$data."
