
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends bind9 dnsutils && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/cache/bind /run/named && \
    chown -R bind:bind /var/cache/bind /run/named

EXPOSE 53/tcp 53/udp

CMD ["/usr/sbin/named", "-g", "-u", "bind"]
