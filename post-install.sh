#/bin/bash

# Set Template for VirtualHosts
Virtualmin > System Settings > Features and Plugins


# Replace the OVH server names in cloud config files
/etc/cloud/cloud.cfg
/var/lib/cloud/data/previous-hostname
/var/lib/cloud/data/set-hostname

# Make sure we have the latest cacert.pem
wget https://curl.haxx.se/ca/cacert.pem -O /etc/ssl/cacert.pem


# This assumes you have setup an SSL certificate with Letsencrypt for the webmin install

# Set a Postfix setting for SSL
Webmin > Servers > Postfix Mail Server > SMTP Authentication And Encryption > 
TLS certificate authority file: /etc/webmin/letsencrypt-ca.pem	



# Point the dovecot SSL files to the webmin set from letsencrypt
cp -sf /etc/webmin/letsencrypt-key.pem /etc/dovecot/private/dovecot.key
cp -sf /etc/webmin/letsencrypt-cert.pem /etc/dovecot/private/dovecot.pem

# Point the postfix SSL files to the webmin set from letsencrypt
cp -sf /etc/webmin/letsencrypt-cert.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
cp -sf /etc/webmin/letsencrypt-key.pem /etc/ssl/private/ssl-cert-snakeoil.key
