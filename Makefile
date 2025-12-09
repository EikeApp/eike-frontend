# renovate: datasource=github-releases depName=EikeApp/eike-content
VERSION=1.0.1

.PHONY: all fetch-content run build-apk build-ios clean help

# Default target
all: run

# Fetch content using the dart script
fetch-content:
	@echo "Fetching content..."
	@flutter pub get > $(if $(OS),NUL,/dev/null) 2>&1
	@dart run tool/fetch_content.dart $(VERSION)

# Run the app (fetches content first)
run: fetch-content
	@echo "Running Flutter app..."
	@flutter run

# Build APK (fetches content first)
build-apk: fetch-content
	@echo "Building APK..."
	@flutter build apk

# Build iOS (fetches content first)
build-ios: fetch-content
	@echo "Building iOS..."
	@flutter build ios

# Clean build artifacts and content cache
clean:
	@echo "Cleaning..."
	@flutter clean
	@dart run tool/fetch_content.dart clean

# Help command
help:
	@echo "Available commands:"
	@echo "  make fetch-content [VERSION=...]  - Fetch content assets (default: from CONTENT_VERSION)"
	@echo "  make run [VERSION=...]            - Run the Flutter app with content"
	@echo "  make build-apk [VERSION=...]      - Build Android APK with content"
	@echo "  make build-ios [VERSION=...]      - Build iOS app with content"
	@echo "  make clean                        - Clean Flutter build and content cache"
