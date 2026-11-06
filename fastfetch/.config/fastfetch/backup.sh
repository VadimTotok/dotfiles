#!/bin/zsh

latest=$(ls -1 /timeshift/snapshots | sort | tail -n 1)
echo "$latest"