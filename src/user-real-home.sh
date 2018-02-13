#!/usr/bin/env sh

find_real_user_home()
{
    REAL_USER_HOME="";

    if [ $UID == 0 ]; then
        USER=$(printenv SUDO_USER);
        if [ -z "$USER" ]; then
            REAL_USER_HOME="$HOME";
        else
            REAL_USER_HOME=$(getent passwd "$USER" | cut -d: -f6);
        fi;
    else
        REAL_USER_HOME="$HOME";
    fi;

    echo $REAL_USER_HOME;
}

find_real_user_home;