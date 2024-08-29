# challengeXPandIT
**Admin Recruitment Challenge**

The main objective is to deploy a sample web app in a tomcat on a docker.
We use self-signed CA certificates created with openssl.



### Repository Content
```bash
challengeXPandIT
├── App
│   └── sample.war
├── clean.sh
├── Dockerfile
├── README.md
├── run.sh
├── setup.sh
├── ssl
│   ├── cert.pem
│   └── key.pem
├── templates
│   ├── centOS
│   └── server.xml
└── test.sh
```

# Usage
## Install dependencies 
Script to install all dependencies and manage docker as a non-root user
```bash
./setup.sh
```

## Create image from Dockerfile and Run container
Script to build image from Dockerfile and run the container.
```bash
./run.sh
```

## Test deployment
Script to test the app deployment. We use `wget` and `openssl` to ensure that ssl/tls is enabled.
```bash
./test.sh
```

## Undeploy and delete
Removes and deletes the container. Adding the `-i` flag also deletes the image built from the Dockerfile.
```bash
./clean.sh [-i]
```