#!/usr/bin/env sh

# Exit immediately on error
set -e

if command -v docker-compose >/dev/null 2>&1; then
  COMPOSE="docker-compose"
else
  COMPOSE="docker compose"
fi

# Common certificate directory
CERT_DIR="./certs"
API_KEY="$CERT_DIR/api.key"
API_CRT="$CERT_DIR/api.crt"
REACT_KEY="$CERT_DIR/react.key"
REACT_CRT="$CERT_DIR/react.crt"

# Generate API self-signed ECDSA certificate if missing
if [ ! -f "$API_KEY" ] || [ ! -f "$API_CRT" ]; then
  echo "[START] Generating API self-signed ECDSA certificate..."
  mkdir -p "$CERT_DIR"
  openssl ecparam -name prime256v1 -genkey -noout -out "$API_KEY"
  openssl req -new -x509 -key "$API_KEY" -out "$API_CRT" -days 365 \
    -subj "/C=ID/ST=Jakarta/L=Jakarta/O=Jokopi/OU=Dev/CN=localhost"
fi

# Generate React Dev Server self-signed RSA certificate if missing
if [ ! -f "$REACT_KEY" ] || [ ! -f "$REACT_CRT" ]; then
  echo "[START] Generating React self-signed RSA certificate..."
  mkdir -p "$CERT_DIR"
  openssl genrsa -out "$REACT_KEY" 2048
  openssl req -new -x509 -key "$REACT_KEY" -out "$REACT_CRT" -days 365 \
    -subj "/C=ID/ST=Jakarta/L=Jakarta/O=Jokopi/OU=Dev/CN=localhost"
fi

echo "[DOCKER] Stopping existing containers..."
$COMPOSE down

echo "[DOCKER] Building and starting containers..."
$COMPOSE up -d --build

echo "[CLEANUP] Pruning unused Docker images..."
docker image prune -f
