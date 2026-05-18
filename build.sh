#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
cargo build --release --target wasm32-unknown-unknown
cp target/wasm32-unknown-unknown/release/tystats.wasm ./tystats.wasm
if command -v wasm-opt >/dev/null 2>&1; then
  wasm-opt -Oz -o tystats.wasm tystats.wasm
fi
echo "built tystats.wasm ($(wc -c < tystats.wasm) bytes)"
