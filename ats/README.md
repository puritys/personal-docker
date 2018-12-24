
Apache traffic server with self signed ssl certificate. The docker image could be only used for testing or debuging, please do not use it on the production.



Quickstart
========

- docker pull puritys/ats
- docker run -dti -p 443:443 -h $(hostname)  -e ATS_REMAP="map / http://$(hostname):4080/" --name ats puritys/ats tail -f /dev/null

Settings
=======
- REMAP: You can define ats remap by  setting env "ATS_REMAP"
- Port:   You can change the port by setting env "ATS_SERVER_PORTS",   -e ATS_SERVER_PORTS="80 443:ssl"


Development
======
- Update Image: docker push puritys/ats 

Reference
=======
- Dockerfile: https://github.com/puritys/personal-docker/blob/master/ats/Dockerfile
