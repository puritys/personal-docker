# personal-docker

## Command

| Container      | command                                                                                         |
| ----           | ----                                                                                            |
| Mysql Client   | docker run -it --rm puritys/command /usr/bin/mysql -h 172.17.0.2 -uroot                         |
| Rollback Mysql | docker run -i --rm puritys/command /usr/bin/mysql -h 172.17.0.2 -uroot --database xxx < zzz.sql |
| Python         | docker run -it --rm -v /pwd/dir:/temp_dir -w /temp_dir puritys/python python2.7                 |
| VPN            | cd vpn; ./exec.sh -c start                                                                      |
| eclim          | cd eclim ; ./exec.sh -c start                                                                   |
| maven          | docker run -it --rm -v /home/puritys/.m2:/root/.m2 -v /pwd/dir:/usr/src/mymaven -w /usr/src/mymaven puritys/command mvn compile |
| java           | docker run -it --rm -v /home/puritys/.m2:/root/.m2 -v /pwd/dir:/usr/src/mymaven -w /usr/src/mymaven puritys/command java        |
| ffmpeg         | docker run -it --rm -w /pwd/dir:/temp_dir puritys/ffmpeg        |



## mtkdocs
- docker run -it --rm -v `pwd`:/doc elamperti/docker-mkdocs build

## gitbook
- docker run --rm -v "$PWD:/gitbook" -p 4000:4000 billryan/gitbook gitbook build
