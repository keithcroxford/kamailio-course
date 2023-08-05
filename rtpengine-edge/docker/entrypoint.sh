#!/bin/bash
set -e

PATH=/usr/local/bin:$PATH

if [ "$1" = 'rtpengine' ]; then
  shift
  exec rtpengine --config-file /etc/rtpengine/rtpengine.conf  "$@"
fi

exec "$@"
