mkdir anyconnect
cd anyconnect

certtool --generate-privkey --outfile ca-key.pem

cat >ca.tmpl <<EOF
cn = "VPN CA"
organization = "puritys Corp"
serial = 1
expiration_days = 36500
ca
signing_key
cert_signing_key
crl_signing_key
EOF

certtool --generate-self-signed --load-privkey ca-key.pem \
--template ca.tmpl --outfile ca-cert.pem

cp ca-cert.pem /etc/ocserv/
