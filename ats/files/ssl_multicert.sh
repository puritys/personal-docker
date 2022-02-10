cat <<EOF
    dest_ip=* ssl_cert_name=cert.pem
EOF

# ssl_key_name=FILENAME
#   The name of the file containing the private key for this certificate.
#   If the key is contained in the certificate file, this field can be
#   omitted.
#
# ssl_ca_name=FILENAME
#   If your certificates have different Certificate Authorities, you
#   can optionally specify the corresponding file here.
#
# ssl_cert_name=FILENAME
#   The name of the file containing the TLS certificate. This is the
#   only field that is required to be present.
#
# ssl_key_dialog=[builtin|exec:/path/to/program]
#   Method used to provide a pass phrase for encrypted private keys.
#   Two options are supported: builtin and exec
#     builtin - Requests passphrase via stdin/stdout. Useful for debugging.
#     exec: - Executes a program and uses the stdout output for the pass
#       phrase.
#
# action=[tunnel]
#   If the tunnel matches this line, traffic server will not participate
#   in the handshake.  But rather it will blind tunnel the SSL connection.
#   If the connection is identified by server name, an openSSL patch must
#   be applied to enable this functionality.  See TS-3006 for details.
#
# Examples:
#   ssl_cert_name=foo.pem
#   dest_ip=*	ssl_cert_name=bar.pem ssl_key_name=barKey.pem
#   dest_ip=209.131.48.79	ssl_cert_name=server.pem ssl_key_name=serverKey.pem
#   dest_ip=10.0.0.1:99 ssl_cert_name=port99.pem
#   ssl_cert_name=foo.pem ssl_key_dialog="exec:/usr/bin/mypass foo 'ba r'"
#   ssl_cert_name=foo.pem action=tunnel
#   ssl_cert_name=wildcardcert.pem ssl_key_name=privkey.pem
