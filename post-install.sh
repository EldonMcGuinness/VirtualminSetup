#/bin/bash

$HOSTNAME="f.q.d.n"
$HOST="f"

# Set Template for VirtualHosts
# Virtualmin > System Settings > Features and Plugins


# Replace the OVH server names in cloud config files
# /etc/cloud/cloud.cfg
# /var/lib/cloud/data/previous-hostname
# /var/lib/cloud/data/set-hostname

# Make sure we have the latest cacert.pem
wget https://curl.haxx.se/ca/cacert.pem -O /etc/ssl/cacert.pem

# This assumes you have setup an SSL certificate with Letsencrypt for the webmin install

# Set a Postfix setting for SSL
# Webmin > Servers > Postfix Mail Server > SMTP Authentication And Encryption > 
# TLS certificate authority file: /etc/webmin/letsencrypt-ca.pem	

# Test postfix:
echo QUIT | openssl s_client -crlf -starttls smtp -CAfile /etc/ssl/cacert.pem -connect $HOSTNAME:587


# Point the dovecot SSL files to the webmin set from letsencrypt
cp -lf /etc/webmin/letsencrypt-key.pem /etc/dovecot/private/dovecot.key
cp -lf /etc/webmin/letsencrypt-cert.pem /etc/dovecot/private/dovecot.pem
chown dovecot /etc/dovecot/private/*

# Point the postfix SSL files to the webmin set from letsencrypt
cp -lf /etc/webmin/letsencrypt-cert.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
cp -lf /etc/webmin/letsencrypt-key.pem /etc/ssl/private/ssl-cert-snakeoil.key
chown dovecot /etc/dovecot/private/*

# Enable the default site so letsencrypt can renew
ln -sf /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/

# Add ssl to the 000-default.conf
# SSLEngine on
# SSLCipherSuite ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP
# SSLCertificateFile      /etc/webmin/letsencrypt-cert.pem
# SSLCertificateKeyFile   /etc/webmin/letsencrypt-key.pem
