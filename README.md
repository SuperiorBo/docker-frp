# docker-frp


# frpc.ini
default file
``` ini
# [common] is integral section
[common]
# A literal address or host name for IPv6 must be enclosed
# in square brackets, as in "[::1]:80", "[ipv6-host]:http" or "[ipv6-host%zone]:80"
server_addr = {{ .Envs.FRP_SERVER_ADDR }}
server_port = 7000

# for authentication
token = {{ .Envs.FRP_TOKEN }}

# connections will be established in advance, default value is zero
pool_count = 5

# if tcp stream multiplexing is used, default is true, it must be same with frps
tcp_mux = true

# your proxy name will be changed to {user}.{proxy}
user = admin

# decide if exit program when first login failed, otherwise continuous relogin to frps
# default is true
login_fail_exit = false

# console or real logFile path like ./frpc.log
log_file = {{ .Envs.FRP_LOG_FILE }}

# trace, debug, info, warn, error
log_level = info
log_max_days = 3

# communication protocol used to connect to server
# now it supports tcp and kcp, default is tcp
protocol = tcp

# Resolve your domain names to [server_addr] so you can use http://web01.yourdomain.com to browse web01 and http://web02.yourdomain.com to browse web02
[web01]
type = https
local_ip = 127.0.0.1
local_port = {{ .Envs.FRP_LOCAL_PORT}}
use_encryption = false
use_compression = false

# if domain for frps is frps.com, then you can access [web01] proxy by URL http://test.frps.com
subdomain = web01
custom_domains = web02.yourdomain.com

# if not empty, frpc will use proxy protocol to transfer connection info to your local service
# v1 or v2 or empty
proxy_protocol_version = v2
```