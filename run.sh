set -e

docker container prune

docker build . -t sample --network host

docker run -ti -p 4041:8080 --name test sample