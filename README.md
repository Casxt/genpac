# genpac
generate pac file form gfwlist and server it on http 80

## Docker

###  Usage
1. `docker pull forer/genpac`
2. ` docker run -p 8080:80 -v /pac_save_dir:/dist --name genpac  genpac --pac-proxy="SOCKS5 127.0.0.1:1080"`
3. view http://host:8080 and download you pac file
4. you can also check out pac file named 'pac' in /pac_save_dir

### Parameter
|parameter short/long|value|describe|
|---------|---|--------|
|p/pac-proxy|"SOCKS5 127.0.0.1:1080"<br>"PROXY 127.0.0.1:1080"<br>"PROXY http://127.0.0.1:1080"|proxy used in your rule|
|gfwlist-proxy|"SOCKS5 127.0.0.1:1080"<br>"PROXY 127.0.0.1:1080"<br>"PROXY http://127.0.0.1:1080"|proxy use to get gfw list (you don't need to set this in most case)|

## RandomProxy
help you to share you pac file with a little more safety.

pac file not have any auth function, if it leak, you proxy are leaked.

RandomProxy start genpac container with a new proxy with random domain, and create config file for caddy that forward this random proxy to your proxy backend. 

if someone get your pac file, you don't need to change your backend, just run RandomProxy, a new pac file will servered, a new random https proxy will forward to you backend, old pac file will disabled at same time.

run RandomProxy every day is enough to keep safe.

###  Usage

`bash RandomProxy.sh -d your_base_domain -s your_backend`

### Parameter
|parameter short/long|value|describe|
|---------|---|--------|
|d/domain|"example.com"|basedomain of random proxy to use, for `example.com`, random domain will like `32cd29b6-b96d-4deb-9990-a348624d8df4.example.com`, set `*.example.com` point to your server, so you can use random subdomain|
|s/source|"http://user:pass@proxy.com"|proxy backend address|
|p/port|"443"|port of random proxy to use, default "443"|
|c/container-name|"genpac"|name and host name of container, default "genpac"|
|config-path|"/etc/caddy"|path of caddy config file, default "/etc/caddy"|
|config-filename|"randomProxy.conf"|filename of caddy config file, default "randomProxy.conf"|
