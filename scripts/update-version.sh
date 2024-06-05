#!/bin/bash

cargo install cargo-edit --quiet
cargo set-version --workspace "$1"
cargo update --workspace
