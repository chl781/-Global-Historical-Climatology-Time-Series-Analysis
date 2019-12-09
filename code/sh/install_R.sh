#!/bin/bash

# http://chtc.cs.wisc.edu/r-jobs.shtml

# First run interactive job via "condor_submit -i interactive.sub" to get
# a command line on a suitable computer.

tar xzf R361.tar.gz
export PATH=$PWD/R/bin:$PATH
export RHOME=$PWD/R
mkdir packages
export R_LIBS=$PWD/packages
packages="c('tseries','ggplot2','tseries','forecast')"
repository="'http://mirror.las.iastate.edu/CRAN'" # cannot use "https" mirror
Rscript -e "install.packages(pkgs=$packages, repos=$repository)"
tar czf packages.tar.gz packages

# note linux version (unnecessary)
#lsb_release -a | tee linuxVersion.txt

exit 0
