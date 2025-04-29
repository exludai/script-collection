#!/usr/bin/bash

# notes
# 1, results has false positive
# 2, unable to handle wrap lines

path="$1"
cmd="find ${path} -name '*.rst' -exec bash -c 'grep -o \"<http[^>]*>\" {} | grep -o \"[^<>]*\"' \;"
mapfile -t urls < <(eval "${cmd}")
for url in "${urls[@]}"; do
  if ! curl --silent --head --fail "$url" > /dev/null; then
    echo "$url"
  fi
done



