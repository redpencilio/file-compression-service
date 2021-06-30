#!/usr/bin/env bash

# Convenience logging function.
info()    {
  now=$(date +%Y%m%dT%H%M%S)
  echo "[INFO] $now:  $@";
}

compress_files() {
  info "Compressing files matching $COMPRESSION_GLOB"
  for gl in $COMPRESSION_GLOB;do
    for file in $gl;do
      if [ -f "$file" ]; then
        # Checks if the file is a file not a directory
        fileTime=$(stat --printf "%Y" "$file")
        curTime=$(date +%s)
        if (( ( ($curTime - $fileTime) / 60 ) > $COMPRESSION_AFTER_MINUTES ))
        then
          info "compressing $file"
          tar -czvf "$COMPRESSION_DIR/$(basename "$file").tar.gz" --directory="$(dirname "$file")" "$(basename "$file")"
          rm "$file"
        fi
      fi
    done
  done
}

if [ -z $COMPRESSION_INTERVAL ];then
  compress_files
else
  while true
  do
    compress_files
    sleep "$COMPRESSION_INTERVAL"
  done
fi
