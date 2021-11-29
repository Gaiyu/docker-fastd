FROM alpine:3 AS builder
WORKDIR /
COPY fastd-21.tar.xz /
RUN set -eux; \
	echo 'nameserver 223.5.5.5' >> /etc/resolv.conf; \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories; \
	echo 'http://mirrors.ustc.edu.cn/alpine/edge/testing' >> /etc/apk/repositories; \
	apk update; \
	apk add build-base bison cmake meson ninja libuecc-dev libcap-dev json-c-dev openssl-dev libsodium-dev clang; \
	tar -xf fastd-21.tar.xz; \
	meson setup fastd-21 fastd-build -Dbuildtype=release; \
	cd fastd-build; \
	ninja
 
FROM alpine:3
WORKDIR /
COPY --from=builder /fastd-build/src/fastd /usr/local/bin
COPY start /usr/local/bin
RUN set -eux; \
	mkdir /peers; \
	echo 'nameserver 223.5.5.5' >> /etc/resolv.conf; \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories; \
	echo 'http://mirrors.ustc.edu.cn/alpine/edge/testing' >> /etc/apk/repositories; \
	apk update; \
	apk add libuecc-dev libcap-dev json-c-dev openssl-dev libsodium-dev iptables
ENTRYPOINT ["start"] 
