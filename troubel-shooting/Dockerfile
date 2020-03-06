FROM alpine:latest
RUN apk add docker nmap tcpdump curl netcat-openbsd nikto libcap-ng-utils scapy py-crypto tcpdump sox graphviz graphviz ebtables --no-cache && rm -f /var/cache/apk/*
ENTRYPOINT ["./bin/sh"]
