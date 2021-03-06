#!/usr/bin/env bash
##~---------------------------------------------------------------------------##
##                        ____                       _   _                    ##
##                  _ __ |___ \ ___  _ __ ___   __ _| |_| |_                  ##
##                 | '_ \  __) / _ \| '_ ` _ \ / _` | __| __|                 ##
##                 | | | |/ __/ (_) | | | | | | (_| | |_| |_                  ##
##                 |_| |_|_____\___/|_| |_| |_|\__,_|\__|\__|                 ##
##                              www.n2omatt.com                               ##
##  File      : install.sh                                                    ##
##  Project   : dots_utils                                                    ##
##  Date      : Dec 15, 2017                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : n2omatt <n2omatt@amazingcow.com>                              ##
##  Copyright : n2omatt - 2017                                                ##
##                                                                            ##
##  Description :                                                             ##
##    Just copy everything under ./src to /usr/local/bin                      ##
##---------------------------------------------------------------------------~##

## Stop om errors...
set -e;

##----------------------------------------------------------------------------##
## Script                                                                     ##
##----------------------------------------------------------------------------##
## Make the target directory if needed.
mkdir -p /usr/local/bin

## Install each script found on ./src
for FILENAME in $(ls ./src); do
    CLEAN_FILENAME=$(basename $FILENAME ".sh");

    cp -fv ./src/$FILENAME /usr/local/bin/$CLEAN_FILENAME;
    chmod 755 /usr/local/bin/$CLEAN_FILENAME;
done;
