#!/usr/bin/env bash
set -e

export TERM=xterm

echo "===== Trojan Docker container starting ====="

echo
echo "===== Check certificate files ====="
ls -lh /usr/src/trojan-cert || true

if [ ! -s /usr/src/trojan-cert/fullchain.cer ]; then
  echo "ERROR: /usr/src/trojan-cert/fullchain.cer not found."
  exit 1
fi

if [ ! -s /usr/src/trojan-cert/private.key ]; then
  echo "ERROR: /usr/src/trojan-cert/private.key not found."
  exit 1
fi

echo
echo "===== Check trojan binary and config ====="
if [ ! -x /usr/src/trojan/trojan ]; then
  echo "ERROR: /usr/src/trojan/trojan not found or not executable."
  exit 1
fi

if [ ! -s /usr/src/trojan/server.conf ]; then
  echo "ERROR: /usr/src/trojan/server.conf not found."
  exit 1
fi

echo
echo "===== Start nginx if not already running ====="
if pgrep -x nginx >/dev/null 2>&1; then
  echo "nginx already running."
else
  nginx || echo "WARNING: nginx start failed, continue anyway."
fi

echo
echo "===== Current listening ports inside container ====="
netstat -lntp | grep -E ':80|:443' || true

echo
echo "===== Start trojan foreground ====="
exec /usr/src/trojan/trojan -c /usr/src/trojan/server.conf
