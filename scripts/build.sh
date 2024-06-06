#!/bin/bash

set -e

# Set default values
PKG=${1:-""}
OS=${2:-"ubuntu-latest"}
TARGET=${3:-"aarch64-unknown-linux-gnu"}
TARGET_DIR="target/${TARGET}/release"
RELEASE_DIR=${4:-"release"}

# Add target architecture
rustup target add "${TARGET}"

# Install aarch64-linux-gnu toolchain for aarch64-unknown-linux-gnu target
if [ "${TARGET}" == "aarch64-unknown-linux-gnu" ]; then
    sudo apt-get install -y gcc-aarch64-linux-gnu
fi

# Build the package
cargo build --release --target "${TARGET}" --package "${PKG}"

# Create the release directory
mkdir -p "${RELEASE_DIR}"

# Copy the executable to the release directory
cp "${TARGET_DIR}/${PKG}" "${RELEASE_DIR}/${PKG}-${TARGET}"
tar -czf "${RELEASE_DIR}/${PKG}-${TARGET}.tgz" -C "${RELEASE_DIR}" "${PKG}-${TARGET}"

echo "✅ Build completed successfully for ${OS}!"
