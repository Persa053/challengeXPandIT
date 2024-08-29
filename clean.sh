#! /bin/bash
set +e

echo "Stopping container..."
echo "====================================================="
docker stop sample

echo "Removing container..."
echo "====================================================="
docker container rm sample

while getopts 'i' OPTION; do
  case "$OPTION" in
    i)
      echo "====================================================="
      echo "Deleting dokcer image..."
      echo "====================================================="
      docker image rm sample_app
      ;;
    ?)
      echo ""
      echo "script usage: $(basename \$0) [-i]" >&2
      exit 1
      ;;
  esac
done