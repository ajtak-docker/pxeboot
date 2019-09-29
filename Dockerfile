FROM alpine:3.7
MAINTAINER Jakub Fridrich <http://jafr.eu>

RUN apk --no-cache add dnsmasq

COPY dnsmasq.conf /etc/
COPY resolv.dnsmasq.conf /etc/

VOLUME /etc/dnsmasq.hosts

EXPOSE 53/udp

ENTRYPOINT ["dnsmasq", "-k"]
