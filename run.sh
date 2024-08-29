#! /bin/bash
set -e

echo "====================================================="
echo "Generate private key and certificate PEM files..."
echo "====================================================="
openssl genrsa -out ssl/key.pem 2048
openssl req -new -x509 -key ssl/key.pem -out ssl/cert.pem -days 365 -subj "/C=US/ST=State/L=City/O=Company/OU=Department/CN=localhost"


echo "====================================================="
echo "Building Image from Dockerfile..."
echo "====================================================="
docker build . -t sample_app --network host

echo "====================================================="
echo "Running docker container..."
echo "====================================================="
docker run -d -p 4041:4041 --name sample sample_app

echo "====================================================="
echo "Sample App available on \"https://localhost:4041/sample\"!"
