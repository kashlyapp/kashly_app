# Simple developer helpers

.PHONY: dev analyze test

dev:
	flutter run --flavor dev --target lib/main_dev.dart --dart-define-from-file=env/dev.json

analyze:
	flutter analyze

test:
	flutter test --coverage
