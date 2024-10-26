#!/bin/sh

docker run \
  --rm \
  --name warp_proxy \
  --network host \
  -e LD_LIBRARY_PATH=/:/usr/lib/x86_64-linux-gnu \
  -e NO_COLOR=1 \
  -e LOGS_DIRECTORY=/logs \
  -e STATE_DIRECTORY=/conf \
  -v ${PWD}/conf:/conf \
  warp_proxy \
  /warp-svc
