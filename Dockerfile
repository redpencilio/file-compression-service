FROM ubuntu:20.04
ENV COMPRESSION_INTERVAL=3600
ENV COMPRESSION_AFTER_MINUTES=60
ENV COMPRESSION_GLOB='/data/logs/*.json'
ENV COMPRESSION_DIR='/data/compressed'
COPY compress.sh /app/compress.sh
CMD ["/app/compress.sh"]
