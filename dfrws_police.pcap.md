# LAN Hosts

|Name|MAC|IP(s)|OUI|Notes|
|----|---|-----|---|-----|
|    |b8:27:eb:0e:3b:45|10.20.30.1|Raspberry PI|Gateway|
|    |18:b4:30:61:c9:ef|10.20.30.13|NestLabs| |
|    |d8:fb:5e:e1:01:92|10.20.30.15| Askey Computer Corp | _most likely QBee camera_ |
|    |08:02:8e:ff:75:4f|10.20.30.17|Netgear | arlo |
|    | _unknown_ | 10.20.30.18 | _unknown_ | _not in pcap but ip present in device logs_ |
|    |18:b4:30:99:9f:85|10.20.30.19|NestLabs| |
|    |ac:5f:3e:73:e3:78|10.20.30.21| Samsung | |
| flex-dvt |b4:79:a7:25:02:fa|10.20.30.22| Samsung | wink |
|    | 74:75:48:96:23:24 | 10.20.30.23 | Amazon Technologies | _amazon echo?_ |

# WAN Hosts

|Name|IP(s)| Communicates with...| Subnet Owner | Notes|
|----|-----|---------------------|--------------|------|
|    |23.23.78.17 | 10.20.30.23→UDP(33434) | Amazon Inc | |
|    |23.23.189.37 | 10.20.30.23→UDP(33434,40317,49317) | Amazon Inc | |
|    |31.13.64.35 | | Facebook | |
|    |31.13.64.16 | | Facebook | |
|    |34.224.5.65 | | Amazon Data Services | |
|    |35.195.59.182 | | Google Cloud | |
|    |52.46.156.66 | | Amazon Data Services Canada | |
|    |54.72.123.194 | | Amazon Data Services Ireland | |
|    |54.152.107.0 | | Amazon Inc | |
|    |66.135.44.92 | | ServerBeach | |
|    |72.21.192.213 | | Amazon | __NTP Server?_ |
|    |130.223.8.20 | | | DNS |
|    |144.76.81.240 | | | |
|    |172.217.23.106 | | | |
|    |172.217.16.142 | | | |
|    |216.58.205.174 | | | |
|    |217.147.208.1 | | | |
| _multicast_ |239.255.255.250| 10.20.30.1→UDP(1900) | | SSDP NOTIFY (upnp) |

