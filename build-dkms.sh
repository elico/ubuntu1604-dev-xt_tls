#!/usr/bin/env bash
set -x
set -e

tar xvf /build/master.tar -C /usr/src
mv /usr/src/xt_tls /usr/src/xt_tls-1.0.0
cd /usr/src/xt_tls-1.0.0
sed -i -e 's@$(shell uname -r)@$(shell ls /lib/modules/)@g' src/Makefile
cp /build/dkms.conf /usr/src/xt_tls-1.0.0/
dkms add -m xt_tls -v 1.0.0
dkms build -m xt_tls -v 1.0.0 -k `ls /lib/modules/`
dkms mkdsc -m xt_tls -v 1.0.0 --source-only
dkms mkdeb -m xt_tls -v 1.0.0 --source-only
cd -

cp /var/lib/dkms/xt_tls/1.0.0/deb/xt-tls-dkms_1.0.0_all.deb /build/destdir/

set +x
set +e
