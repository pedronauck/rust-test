#!/bin/bash

cargo install cargo-edit
cargo set-version --workspace "$1"
cargo update --workspace
