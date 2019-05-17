FROM alpine:latest
RUN apk add nmap tcpdump curl netcat-openbsd nikto --no-cache && rm -f /var/cache/apk/*
ENTRYPOINT ["./bin/sh"]
