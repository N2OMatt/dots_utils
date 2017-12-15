#!/bin/bash
##~---------------------------------------------------------------------------##
##                        ____                       _   _                    ##
##                  _ __ |___ \ ___  _ __ ___   __ _| |_| |_                  ##
##                 | '_ \  __) / _ \| '_ ` _ \ / _` | __| __|                 ##
##                 | | | |/ __/ (_) | | | | | | (_| | |_| |_                  ##
##                 |_| |_|_____\___/|_| |_| |_|\__,_|\__|\__|                 ##
##                              www.n2omatt.com                               ##
##  File      : expand-inplace.sh                                             ##
##  Project   : dots_utils                                                    ##
##  Date      : Dec 15, 2017                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : n2omatt <n2omatt@amazingcow.com>                              ##
##  Copyright : n2omatt - 2017                                                ##
##                                                                            ##
##  Description :                                                             ##
##      Simple wrapper around the expand(1) to make easiser to                ##
##      expand tabs in-place                                                  ##
##---------------------------------------------------------------------------~##

##----------------------------------------------------------------------------##
## Script                                                                     ##
##----------------------------------------------------------------------------##
FILENAME=$1;
TEMP="${FILENAME}.temp";


if [ -z "$FILENAME" ]; then
    echo "Missing filename...";
    exit 1;
fi;

expand -t 4 "$FILENAME" > "$TEMP";
mv -f "$TEMP" "$FILENAME";
