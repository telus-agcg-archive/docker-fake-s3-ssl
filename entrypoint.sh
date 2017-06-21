#!/bin/sh

# Ensure we have a fake certificate available for the given hostname
set -e

openssl req \
  -new \
  -x509 \
  -days 365 \
  -nodes \
  -out /etc/ssl/certs/fakes3.pem \
  -keyout /etc/ssl/certs/fakes3.key \
  -subj "/C=US/ST=Fake/L=S3/O=FakeS3/CN=*.$HOST_NAME"

chmod 0600 /etc/ssl/certs/fakes3.pem
chmod 0600 /etc/ssl/certs/fakes3.key

exec fakes3 \
  -r /var/lib/fakes3/data \
  -p 443 \
  --sslcert=/etc/ssl/certs/fakes3.pem \
  --sslkey=/etc/ssl/certs/fakes3.key \
  "$@"
