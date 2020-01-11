#/bin/bash

# Replace the OVH server names in cloud config files
/etc/cloud/cloud.cfg
/var/lib/cloud/data/previous-hostname
/var/lib/cloud/data/set-hostname

# This assumes you have setup an SSL certificate with Letsencrypt for the webmin install



# Point the dovecot SSL files to the webmin set from letsencrypt
cp -sf /etc/webmin/letsencrypt-key.pem /etc/dovecot/private/dovecot.key
cp -sf /etc/webmin/letsencrypt-cert.pem /etc/dovecot/private/dovecot.pem

# Point the postfix SSL files to the webmin set from letsencrypt
cp -sf /etc/webmin/letsencrypt-cert.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
cp -sf /etc/webmin/letsencrypt-key.pem /etc/ssl/private/ssl-cert-snakeoil.key
