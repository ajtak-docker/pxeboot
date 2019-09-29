FROM alpine:3.7
MAINTAINER Jakub Fridrich <https://jafr.eu/>

RUN apk --no-cache add dnsmasq

COPY dnsmasq.conf /etc/

#VOLUME /etc/dnsmasq.hosts

EXPOSE 53/udp

ENTRYPOINT ["dnsmasq", "-k"]
