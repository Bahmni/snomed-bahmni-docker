FROM alpine:latest
RUN apk --no-cache add curl
COPY load-data.sh /load-data.sh
RUN chmod +x /load-data.sh
CMD ["/load-data.sh"]