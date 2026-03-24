# renovate: datasource=github-releases depName=EikeApp/eike-content
VERSION=3.0.0

.PHONY: all fetch-content run build-apk build-ios clean help

# Default target
all: run

# Fetch content using the dart script
fetch-content:
	@(cd packages/tools_fetch_content && dart pub get && dart run bin/tools_fetch_content.dart $(VERSION))

# Run the app (fetches content first)
run: fetch-content
	@(cd packages/eike_app && flutter run)

# Build APK (fetches content first)
build-apk: fetch-content
	@(cd packages/eike_app && flutter build apk --release)

# Build iOS (fetches content first)
build-ios: fetch-content
	@(cd packages/eike_app && flutter build ios --release)

# Clean build artifacts and content cache
clean:
	@(cd packages/tools_fetch_content && dart run bin/tools_fetch_content.dart clean)
	@(cd packages/eike_app && flutter clean)
	@echo "Searching for modules in $(CURDIR)/packages"
	@if [ ! -d "packages" ]; then \
		echo "Error: Directory 'packages' not found."; \
		exit 1; \
	fi
	@found=0; \
	for dir in in packages/*/; do \
		dir=$${dir%/}; \
		if [ -d "$$dir/.dart_tool" ] || [ -d "$$dir/build" ]; then \
			echo "→ Flutter clean: $$dir"; \
			(cd "$$dir" && flutter clean); \
			found=$$((found + 1)); \
		fi; \
	done; \
	if [ $$found -eq 0 ]; then \
		echo "No modules have been found."; \
	else \
		echo "Done. $$found Projects have been cleaned."; \
	fi

# Help command
help:
	@echo "Available commands:"
	@echo "  make fetch-content [VERSION=...]  - Fetch content assets (default: from CONTENT_VERSION)"
	@echo "  make run [VERSION=...]            - Run the Flutter app with content"
	@echo "  make build-apk [VERSION=...]      - Build Android APK with content"
	@echo "  make build-ios [VERSION=...]      - Build iOS app with content"
	@echo "  make clean                        - Clean Flutter build and content cache"
