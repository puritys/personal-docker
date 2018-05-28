
# https://docs.docker.com/registry/deploying/
# https://docs.docker.com/registry/insecure/#docker-still-complains-about-the-certificate-when-using-authentication

- ./exec.sh  -c init --host dev.puritys.me --port 5000
- ./exec.sh  -c start --host dev.puritys.me --port 5000 --dockerPath /var/www/


