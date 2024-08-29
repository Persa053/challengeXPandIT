#!/bin/bash
set -e

SITE="localhost:4041"
APP="https://localhost:4041/sample"
CERT_PATH="ssl/cert.pem"

# Check if site is valid https
if openssl s_client -connect "${SITE}" </dev/null 2>/dev/null | grep -q 'Verify return code: 18 (self-signed certificate)'; then
  echo "Site ${SITE} is valid https (self-signed certificate)"
  echo "====================================================="

else
  echo "Site ${SITE} is not valid https"
  echo "====================================================="

  exit 1
fi

echo "Testing HTTPS URL $APP with certificate $CERT_PATH..."
echo "====================================================="
wget --spider --ca-certificate="$CERT_PATH" --server-response "$APP"

echo "====================================================="
echo "Everithing seems to be working :)"
echo "====================================================="
