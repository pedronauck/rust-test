#!/bin/bash

set -e

# Set default values
PKG=${1:-""}
OS=${2:-"macos-latest"}
TARGET=${3:-"aarch64-apple-darwin"}
TARGET_DIR="target/${TARGET}/release"
RELEASE_DIR=${4:-"release"}

# Add target architecture
rustup target add "${TARGET}"

# Install musl-tools for x86_64-unknown-linux-musl target
if [ "${TARGET}" == "x86_64-unknown-linux-musl" ]; then
    sudo apt-get install -y musl-tools
fi

# Build the package
RUSTFLAGS='-C link-arg=-s' cargo build --release --target "${TARGET}" --package "${PKG}"

# Copy the executable to the release directory
if [ "${OS}" == "windows-latest" ]; then
    cp "${TARGET_DIR}/${PKG}.exe" "${RELEASE_DIR}/${PKG}-${TARGET}.exe"
    7z a -tzip "${RELEASE_DIR}/${PKG}-${TARGET}.zip" "${RELEASE_DIR}/${PKG}-${TARGET}.exe"
else
    cp "${TARGET_DIR}/${PKG}" "${RELEASE_DIR}/${PKG}-${TARGET}"
    tar -czf "${RELEASE_DIR}/${PKG}-${TARGET}.tgz" -C "${RELEASE_DIR}" "${PKG}-${TARGET}"
fi

echo "✅ Build completed successfully!"
