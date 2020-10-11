
Apache traffic server with self signed ssl certificate. The docker image could be only used for testing or debuging, please do not use it on the production.



Quickstart
========

- docker pull puritys/ats
- docker run -dti -p 443:443 -h $(hostname)  -e ATS_REMAP="map / http://$(hostname):4080/" --name ats puritys/ats

Start on docker compose:

```
  ats:
    container_name: ats
    image: "puritys/ats"
    ports:
      - "443:443"
      - "80:80"
    environment:
      - logFormat=rich
      - |
        ATS_REMAP=map http://zzz.com.tw/  http://service1/   @plugin=conf_remap.so @pparam=proxy.config.url_remap.pristine_host_
hdr=1
        map https://bbb.com.tw/           http://service2/
```

Settings
=======
- REMAP: You can define ats remap by  setting env "ATS_REMAP"
- Port:   You can change the port by setting env "ATS_SERVER_PORTS",   -e ATS_SERVER_PORTS="80 443:ssl"

Environment
======

### log format

logFormat = rich

- squid(default)
- rich:

directory
==========

- log files: /usr/local/var/log/trafficserver
- conf files: /usr/local/etc/trafficserver



read log: docker exec -ti $container  tail -f /usr/local/var/log/trafficserver/squid.log

Development
======
- Update Image: docker push puritys/ats 

Reference
=======
- Dockerfile: https://github.com/puritys/personal-docker/blob/master/ats/Dockerfile
