#!/bin/sh
set -m

warp-svc &
sleep 5

warp-cli --accept-tos status

if ([ "$WARP_TEAMS_ACCESS_CLIENT_ID"     != "" ] &&
    [ "$WARP_TEAMS_ACCESS_CLIENT_SECRET" != "" ]); then
  warp-cli --accept-tos teams-enroll                            \
    --access-client-id "$WARP_TEAMS_ACCESS_CLIENT_ID"	        \
    --access-client-secret "$WARP_TEAMS_ACCESS_CLIENT_SECRET"   \

elif [ "$WARP_MANUAL" == "" ]; then
  warp-cli --accept-tos register
fi

warp-cli --accept-tos connect

socat TCP-LISTEN:${WARP_PROXY_PORT},fork,reuseaddr TCP4:127.0.0.1:40000

bash # for debugging
