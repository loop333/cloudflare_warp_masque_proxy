#!/bin/sh

docker exec -it warp_proxy /warp-cli mode proxy
docker exec -it warp_proxy /warp-cli tunnel protocol set MASQUE