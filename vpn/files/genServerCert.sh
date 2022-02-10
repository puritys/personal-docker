cd anyconnect
certtool --generate-privkey --outfile server-key.pem

cat >server.tmpl <<EOF
cn = "www.puritys.me"
organization = "MyCompany"
serial = 2
expiration_days = 365
encryption_key
signing_key
tls_www_server
EOF

certtool --generate-certificate --load-privkey server-key.pem \
--load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem \
--template server.tmpl --outfile server-cert.pem

cp server-cert.pem /etc/ocserv/
cp server-key.pem /etc/ocserv/
