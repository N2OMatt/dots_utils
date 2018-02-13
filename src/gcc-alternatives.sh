#!/usr/bin/env bash


##----------------------------------------------------------------------------##
## Functions                                                                  ##
##----------------------------------------------------------------------------##
function last_version()
{
    /usr/bin/ls /usr/bin/$1* \
        | sort -r            \
        | grep $1-[0-9]      \
        | head -1            \
        | sed s#/usr/bin/##g
}


##----------------------------------------------------------------------------##
## Script                                                                     ##
##----------------------------------------------------------------------------##
##------------------------------------------------------------------------------
## Find out the last gcc version installed.
GCC=$(last_version gcc);
GPP=$(last_version g++);

##------------------------------------------------------------------------------
## Update the defaults.
update-alternatives --install /usr/bin/gcc gcc /usr/bin/$GCC 20
update-alternatives --install /usr/bin/g++ g++ /usr/bin/$GPP 20

update-alternatives --install /usr/bin/cc  cc  /usr/bin/gcc 30
update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30

update-alternatives --set cc  /usr/bin/gcc
update-alternatives --set c++ /usr/bin/g++

update-alternatives --config gcc
update-alternatives --config g++