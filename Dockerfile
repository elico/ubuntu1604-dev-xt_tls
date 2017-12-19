FROM ubuntu:16.04

ENV	DEBIAN_FRONTEND=noninteractive

ADD	sources.list /etc/apt/sources.list
RUN	apt-get update \
	&& apt-get upgrade -y

RUN 	apt-get install -y linux-headers-generic-lts-xenial linux-generic-lts-xenial \
	&& apt-get install -y build-essential iptables-dev iptables libnetfilter-conntrack-dev \
	&& apt-get install -y autoconf libtool git libpcap-dev pkg-config xtables-addons-source \
	&& apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y

#		xtables-addons-common xtables-addons-dkms xtables-addons-source \
RUN 	apt-get install -y libssl-dev openssl mokutil dkms
ADD 	clean.sh /clean.sh

RUN	chmod +x /clean.sh \
	&& /bin/bash clean.sh

RUN mkdir /build
VOLUME /build
CMD ["/build/build.sh"]
