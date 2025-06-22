#!/bin/zsh

birth_install=$(stat -c %W / 2>/dev/null)

if [[ "$birth_install" -le 0 ]]; then
  birth_install=$(date +%s)
fi

current=$(date +%s)
days=$(( (current - birth_install) / 86400 ))

echo "$days"
