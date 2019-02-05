#! /bin/bash
baseDomain="example.com"
port="443"
upStream="http://user:pass@localhost:80"
#
containerName="genpac"
# 
configFileName="randomProxy.conf"
configPath="/etc/caddy/"
configTemplate="{DomainName}:{Port} {
    forwardproxy {
        hide_via
        upstream {UpStream}
    }
}
"
# get parameter
OPTIONS=d:p::s:c::
LONGOPTS=domain:,port::,source::,config-filename::,config-path::,config-template::,container-name::
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
eval set -- "$PARSED"
while true; do
    case $1 in
        -d | --domain ) baseDomain=$2; shift 2 ;;
        -p | --port ) port=$2; shift 2 ;;
        -s | --source ) upStream=$2; shift 2 ;;
        -c | --container-name ) containerName=$2; shift 2 ;;
        --config-filename ) configFileName=$2; shift 2 ;;
        --config-path ) configPath=$2; shift 2 ;;
        --config-template ) configTemplate=$(cat $2); shift 2 ;;
        -- ) shift; break ;;
        * ) break ;;
    esac
done


# get new random proxy subdomain
domainName=$(cat /proc/sys/kernel/random/uuid).$baseDomain
echo "New Domain is: $domainName"
echo ""

# generator config file
config=${configTemplate//"{DomainName}"/$domainName}
config=${config//"{Port}"/$port}
config=${config//"{UpStream}"/$upStream}
echo "$config" > $configPath/$configFileName

# restart docker
echo "stop container :"
docker stop $containerName 
echo "remove container :"
docker rm $containerName

echo "start new container $containerName"
docker run -d \
--name $containerName \
--hostname $containerName \
--restart unless-stopped \
forer/genpac \
--pac-proxy="HTTPS $domainName:$port"
echo ""

# restart caddy
echo "restart caddy"
systemctl restart caddy.service
