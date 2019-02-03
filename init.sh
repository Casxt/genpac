#!/bin/sh

# NOTE: This requires GNU getopt.  On Mac OS X and FreeBSD, you have to install this
# separately; see below.
echo $@

set -- $(getopt -o p: --long pac-proxy:,gfwlist-proxy:: -n 'parse-options' -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!


echo $@

PAC_PROXY=
GFWLIST_PROXY=""
while true; do
    case $1 in
        -p | --pac-proxy ) PAC_PROXY="$2"; shift 2 ;;
        --gfwlist-proxy ) GFWLIST_PROXY=`--gfwlist-proxy="$2"`; shift 2 ;;
        -- ) shift; break ;;
        * ) break ;;
    esac
done

darkhttpd /dist --chroot --index pac --port 80 --daemon

while :
do
    genpac --format=pac --pac-compress -o /dist/pac --pac-proxy="$PAC_PROXY" $GFWLIST_PROXY
    # genpac --format=dnsmasq --pac-compress -o /dist/dnsmasq --pac-proxy="$PAC_PROXY"  $GFWLIST_PROXY
    # genpac --format=wingy --pac-compress -o /dist/wingy --pac-proxy="$PAC_PROXY"  $GFWLIST_PROXY
    sleep 1h
done
