# renovate: datasource=github-releases depName=EikeApp/eike-content
VERSION=3.0.1

# Gradle's launcher JVM loads native-platform through System::load. On JDK 24+
# this prints a "restricted method" warning unless native access is enabled.
export GRADLE_OPTS := --enable-native-access=ALL-UNNAMED

.PHONY: all fetch-content run build-apk build-ios clean help

# Default target
all: fetch-content run build-apk build-ios clean

# Fetch content using the shell script
fetch-content:
	@(cd scripts && ./fetch_content.sh $(VERSION))

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
	@(cd packages/eike_app && flutter clean)

# Help command
help:
	@echo "Available commands:"
	@echo "  make fetch-content [VERSION=...]  - Fetch content assets (default: from CONTENT_VERSION)"
	@echo "  make run [VERSION=...]            - Run the Flutter app with content"
	@echo "  make build-apk [VERSION=...]      - Build Android APK with content"
	@echo "  make build-ios [VERSION=...]      - Build iOS app with content"
	@echo "  make clean                        - Clean Flutter build and content cache"
