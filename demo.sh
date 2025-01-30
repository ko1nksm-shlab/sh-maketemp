#!/bin/sh

. ./maketemp.sh

echo "=== maketemp ==="
tmp=$(maketemp)
ls -ld "$tmp"
echo

echo "=== maketemp (prefix) ==="
tmp=$(maketemp prefix)
ls -ld "$tmp"
echo

echo "=== maketemp -dir ==="
tmp=$(maketemp -dir)
ls -ld "$tmp"
echo

echo "=== maketemp -fifo ==="
tmp=$(maketemp -fifo)
ls -ld "$tmp"
echo

