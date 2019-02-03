# genpac

## Usage

1. `docker pull forer/genpac`
2. ` docker run -p 8080:80 --name genpac  genpac --pac-proxy="SOCKS5 127.0.0.1:1080"`

## Parameter
|parameter short/long|arg|describe|
|---------|---|--------|
|p/pac-proxy|"SOCKS5 127.0.0.1:1080"<br>"PROXY 127.0.0.1:1080"<br>"PROXY http://127.0.0.1:1080"|proxy used in your rule|
|gfwlist-proxy|"SOCKS5 127.0.0.1:1080"<br>"PROXY 127.0.0.1:1080"<br>"PROXY http://127.0.0.1:1080"|proxy use to get gfw list (you don't need to set this in most case)|
