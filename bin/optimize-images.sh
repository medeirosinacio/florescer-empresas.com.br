#!/usr/bin/env sh

IMAGE_DIRS="/app/assets/images"
HASH_FILE="/app/_data/.optimized-images"

# Install dependencies
npm install sharp-cli -g
touch "$HASH_FILE"
mkdir -p /app/.images-cache

# Find and optimize images
find $IMAGE_DIRS -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) 2>/dev/null | while read img; do

  # Check if image has already been optimized
  hash=$(sha256sum "$img" | cut -d' ' -f1)
  if grep -q "$hash" "$HASH_FILE"; then
    echo "IGNORE: $img"
    continue
  fi

  # Define file paths
  filename="${img##*/}"
  name="${filename%.*}"
  ext="${filename##*.}"
  dir="${img%/*}"
  optimized_file="/app/.images-cache/${name}.jpg"
  new_file="$dir/${name}.jpg"

  echo "OPTIMIZE: $img"
  sharp -i "$img" -o "$optimized_file" \
      --quality 85 \
      --format jpeg \
      --progressive \
      --optimiseCoding \
      --mozjpeg

  if [ ! -f "$optimized_file" ]; then
    echo "ERROR: Optimization failed for $img"
    continue
  fi

  # Replace original image with optimized image
  rm "$img"
  mv "$optimized_file" "$new_file"
  new_hash=$(sha256sum "$new_file" | cut -d' ' -f1)
  echo "$new_hash $new_file" >> "$HASH_FILE"
done
