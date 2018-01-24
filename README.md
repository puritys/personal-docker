# personal-docker

## Command

* Mysql Client: docker run -it --rm puritys/command /usr/bin/mysql -h 172.17.0.2 -uroot
* Rollback Mysql: docker run -i --rm puritys/command /usr/bin/mysql -h 172.17.0.2 -uroot --database xxx < zzz.sql
* Python: docker run -it --rm -v /pwd/dir:/temp_dir -w /temp_dir puritys/python python2.7
