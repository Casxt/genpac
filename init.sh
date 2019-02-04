#!/bin/sh

# NOTE: This requires GNU getopt.  On Mac OS X and FreeBSD, you have to install this
# separately; see below.
echo "$@"

OPTIONS=p:
LONGOPTS=pac-proxy:,gfwlist-proxy::

# -use ! and PIPESTATUS to get exit code with errexit set
# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"

# Note the quotes around `$TEMP': they are essential!

PAC_PROXY=
GFWLIST_PROXY=""
while true; do
    case $1 in
        -p | --pac-proxy ) PAC_PROXY=$2; shift 2 ;;
        --gfwlist-proxy ) GFWLIST_PROXY=`--gfwlist-proxy="$2"`; shift 2 ;;
        -- ) shift; break ;;
        * ) break ;;
    esac
done

darkhttpd /dist --chroot --index pac --port 80 --daemon

echo "use proxy: '$PAC_PROXY'"

while :
do
    genpac --format=pac --pac-compress -o /dist/pac --pac-proxy="$PAC_PROXY" $GFWLIST_PROXY
    # genpac --format=dnsmasq --pac-compress -o /dist/dnsmasq --pac-proxy="$PAC_PROXY"  $GFWLIST_PROXY
    # genpac --format=wingy --pac-compress -o /dist/wingy --pac-proxy="$PAC_PROXY"  $GFWLIST_PROXY
    sleep 1h
done