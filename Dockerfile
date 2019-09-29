FROM alpine:3.7
MAINTAINER Gerard Braad <me@gbraad.nl>

RUN apk --no-cache add dnsmasq

COPY remov/dnsmasq.conf.my /etc/
COPY resolv.dnsmasq.conf /etc/

VOLUME /etc/dnsmasq.hosts

EXPOSE 53/udp

ENTRYPOINT ["dnsmasq", "-k"]
