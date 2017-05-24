# AWS EC2 Instance Monitor in a Docker Container

<img src="https://cloud.githubusercontent.com/assets/2662304/19168687/f6a567be-8c19-11e6-8561-ce8d589e8346.gif"/>

# Description

Ubuntu 16.04 container hosting a website for monitoring many performance details in real time.

Powered by Netdata https://github.com/firehol/netdata

**netdata** is a system for **distributed real-time performance and health monitoring**.
It provides **unparalleled insights, in real-time**, of everything happening on the
system it runs (including applications such as web and database servers), using
**modern interactive web dashboards**.

_netdata is **fast** and **efficient**, designed to permanently run on all systems
(**physical** & **virtual** servers, **containers**, **IoT** devices), without
disrupting their core function._

https://hub.docker.com/r/felipederodrigues/ec2_monitor/


# How to use it ?

Run this command in a terminal:
```console
docker run -ti --rm -p 19999:19999 --name monitor --detach felipederodrigues/ec2_monitor:v1 && docker logs -f monitor
```
And wait for the following screen:

![image](https://cloud.githubusercontent.com/assets/7635127/26420352/b5ed8f9c-4098-11e7-83d0-edda9489cac0.png)

Simple as that.

Now access from any browser: SERVER_IP_ADDRESS:19999
