# genpac

## Usage

1. `docker pull forer/genpac`
2. ` docker run -p 8080:80 -v /pac_save_dir:/dist --name genpac  genpac --pac-proxy="SOCKS5 127.0.0.1:1080"`
3. view http://host:8080 and download you pac file
4. you can also check out pac file named 'pac' in /pac_save_dir

## Parameter
|parameter short/long|arg|describe|
|---------|---|--------|
|p/pac-proxy|"SOCKS5 127.0.0.1:1080"<br>"PROXY 127.0.0.1:1080"<br>"PROXY http://127.0.0.1:1080"|proxy used in your rule|
|gfwlist-proxy|"SOCKS5 127.0.0.1:1080"<br>"PROXY 127.0.0.1:1080"<br>"PROXY http://127.0.0.1:1080"|proxy use to get gfw list (you don't need to set this in most case)|
