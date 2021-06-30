# file-compression-service
A docker container to compress files using `tar`

## Getting started
Add the following snippet to your `docker-compose.yml`:

```yml
services:
  compress:
    image: redpencil/file-compression-service:1.0.0
    volumes:
      - ./data/logs/stats:/data/logs:rw
      - ./data/compressed/stats:/data/compressed:rw
```

The files mounted in `/data/logs` matching the defined `COMPRESSION_GLOB` will be compressed. The resulting files are written to `/data/compressed`.

## Reference
### Environment variables
Configuration is done via environment variables

* `COMPRESSION_AFTER_MINUTES`: Compress matching files with mtime of at least the configured amount of minutes (default: 60)
* `COMPRESSION_GLOB`: Pattern of files to compress, supports bash globbing. You can provide multiple patterns split by a space (default: `/data/logs/*.json`)
* `COMPRESSION_INTERVAL`: Interval to run at in seconds, empty string to disable (default 1h, 3600)
* `COMPRESSION_DIR`: Folder inside container to write compressed files to (default `/data/compressed`)
