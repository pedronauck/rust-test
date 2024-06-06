# ------------------------------------------------------------
#  Setup
# ------------------------------------------------------------

install:
	cargo fetch

setup:
	./scripts/setup.sh

# ------------------------------------------------------------
#  Development
# ------------------------------------------------------------

dev:
	cargo run

dev-watch:
	cargo watch -- cargo run

# ------------------------------------------------------------
# Build & Release
# ------------------------------------------------------------

build:
	cargo build --release

run:
	cargo run --release

# ------------------------------------------------------------
# Format
# ------------------------------------------------------------

fmt: fmt-cargo fmt-rust fmt-markdown

fmt-cargo:
	cargo sort -w

fmt-rust:
	cargo +nightly fmt -- --color always

fmt-markdown:
	npx prettier *.md **/*.md --write --no-error-on-unmatched-pattern

# ------------------------------------------------------------
# Validate code
# ------------------------------------------------------------

check:
	cargo check --all-targets --all-features

lint: check lint-cargo lint-rust lint-clippy lint-markdown

lint-cargo:
	cargo sort -w --check

lint-rust:
	cargo +nightly fmt -- --check --color always

lint-clippy:
	cargo clippy --workspace -- -D warnings

lint-markdown:
	npx prettier *.md **/*.md --check --no-error-on-unmatched-pattern
