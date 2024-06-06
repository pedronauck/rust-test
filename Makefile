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

fmt: fmt-rust fmt-markdown

fmt-rust:
	cargo +nightly fmt -- --color always

fmt-markdown:
	npx prettier *.md **/*.md --write --no-error-on-unmatched-pattern

# ------------------------------------------------------------
# Validate code
# ------------------------------------------------------------

check:
	cargo check --all-targets --all-features

lint:
	pre-commit run --all-files

lint-clippy:
	cargo clippy --workspace -- -D warnings
