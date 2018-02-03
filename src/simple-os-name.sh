#!/usr/bin/env bash


## type:
##   gnu_linux
##   osx
##   minix
##   bsd

## kernel:
##   linux
##   darwin
##   microsoft
##   bsd

## distro:
##   ubuntu | debian | opensuse | etc
##   tiger | leopard | mavericks | lion | etc
##   cygwin | msys
##   trueos | freebsd | netbsd | etc

##----------------------------------------------------------------------------##
## "Constants"                                                                ##
##----------------------------------------------------------------------------##
FLAG_TYPE=$(( 1 << 0 ));
FLAG_KERNEL=$(( 1 << 1 ));
FLAG_DISTRO=$(( 1 << 2 ));
FLAG_ALL=$(( FLAG_TYPE | FLAG_KERNEL | FLAG_DISTRO ));

##----------------------------------------------------------------------------##
## Variables                                                                  ##
##----------------------------------------------------------------------------##
OS_TYPE="";
OS_KERNEL="";
OS_DISTRO="";

OS_INFO="";

##----------------------------------------------------------------------------##
## Functions                                                                  ##
##----------------------------------------------------------------------------##
discover_everything()
{
    case $(uname -s | tr [:upper:] [:lower:] ) in
        ## For our purposes the Cygwin, MinGW and Msys are treated as distros.
        *msys*   ) OS_TYPE="msys";   OS_KERNEL="microsoft"; OS_DISTRO="msys"   ;;
        *mingw*  ) OS_TYPE="mingw";  OS_KERNEL="microsoft"; OS_DISTRO="mingw"  ;;
        *cygwin* ) OS_TYPE="cygwin"; OS_KERNEL="microsoft"; OS_DISTRO="cygwin" ;;

        ## GNU/Linux.
        *linux* )
            OS_TYPE="gnu_linux";
            OS_DISTRO=$(cat /etc/os-release | grep ^ID= | sed s/ID=//);

            local is_wsl=$(uname -r | grep -i microsoft);
            if [ -n "$is_wsl" ]; then
                OS_KERNEL="microsoft";
            else
                OS_KERNEL="linux";
            fi;
        ;;

        ## Other Unices.
        ## COWTODO(n2omatt): Implement...
        # *minix* ) OS_TYPE="minix"; OS_KERNEL="minix"; OS_DISTRO="minix"; ;;
        # *darwin*) OS_TYPE="osx";   OS_KERNEL="darvin" OS_DISTRO="NOT_IMPLEMENTED_YET"; ;;
        # *bsd*   ) OS_TYPE="bsd";   ;;
    esac;
}


show_help()
{
    echo "" > /dev/null
    ## COWTODO(n2omatt): Implement...
}

append_info()
{
    if [ -z "$OS_INFO" ]; then
        OS_INFO="$1";
    else
        OS_INFO="$OS_INFO $1"
    fi;
}



##----------------------------------------------------------------------------##
## Entry Point                                                                ##
##----------------------------------------------------------------------------##
main()
{
    ## Well... Discover everything that we can about the system.
    discover_everything;

    ## Parse the command line options.
    OPT=0;
    FLAGS="$@";
    test $# == 0 && FLAGS="--all";

    for FLAG in $FLAGS; do
        case $FLAG in
            --all    ) OPT=$FLAG_ALL; break; ;;
            --type   ) OPT=$(( OPT | FLAG_TYPE )); ;;
            --kernel ) OPT=$(( OPT | FLAG_KERNEL )); ;;
            --distro ) OPT=$(( OPT | FLAG_DISTRO )); ;;
        esac
    done;

    test $(( OPT & FLAG_TYPE   )) != 0 && append_info "$OS_TYPE";
    test $(( OPT & FLAG_KERNEL )) != 0 && append_info "$OS_KERNEL";
    test $(( OPT & FLAG_DISTRO )) != 0 && append_info "$OS_DISTRO";

    echo "$OS_INFO";
}

main "$@";
