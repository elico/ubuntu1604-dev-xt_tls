#!/usr/bin/env bash

set -e
set -x

if [ "$1" == "no-cache" ]; then
  docker build --no-cache -t local/ubuntu1604-ndpi .
else
  docker build -t local/ubuntu1604-ndpi .
fi

docker run -i -t -v `pwd`:/build/ local/ubuntu1604-ndpi /build/build.sh

cd destdir
tar cvfJ xt_tls.tar.xz ./*
tar tvf xt_tls.tar.xz
cd -

docker run -i -t -v `pwd`:/build/ local/ubuntu1604-ndpi /build/build-dkms.sh

set +x
