build:
	cargo build --release

check:
	cargo check --all-targets --all-features

dev:
	cargo run

dev-watch:
	cargo watch -- cargo run

fmt:
	cargo +nightly fmt

install:
	cargo fetch

lint:
	pre-commit run --all-files

run:
	cargo run --release

setup:
	./scripts/setup.sh

changeset:
	knope changeset
