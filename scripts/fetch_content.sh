#!/bin/zsh

set -euo pipefail

VERSION="${1:-${VERSION:-}}"

if [[ -z "${VERSION}" ]]; then
  echo "No version provided!"
  echo "Usage: $0 <version> OR VERSION=... $0"
  exit 1
fi

SCRIPT_DIR="${0:A:h}"
TARGET_DIR="${SCRIPT_DIR}/../packages/eike_app/assets/content"
REPO_URL="https://github.com/EikeApp/eike-content"

WORK_DIR="$(mktemp -d)"
trap 'rm -rf "${WORK_DIR}"' EXIT

ZIP_FILE="${WORK_DIR}/content.zip"

echo "Downloading version ${VERSION} ..."
curl --fail --show-error --location --retry 3 \
  "${REPO_URL}/archive/refs/tags/${VERSION}.zip" -o "${ZIP_FILE}"

echo "Unzipping ..."
unzip -q "${ZIP_FILE}" -d "${WORK_DIR}"

# Don't assume GitHub's auto-generated folder name (e.g. it changes if the
# tag ever gets a "v" prefix) - just take whatever single directory the
# archive extracted to.
EXTRACTED_DIR="$(find "${WORK_DIR}" -mindepth 1 -maxdepth 1 -type d)"

if [[ -z "${EXTRACTED_DIR}" ]]; then
  echo "Could not find extracted content directory in archive!"
  exit 1
fi

for entry in "7-things" "data.yaml"; do
  if [[ ! -e "${EXTRACTED_DIR}/${entry}" ]]; then
    echo "Expected '${entry}' in downloaded content but it is missing!"
    echo "Did the content repo's structure change?"
    exit 1
  fi
done

# Only touch the real target directory once we know we have everything we
# need - if anything above fails, the existing content stays untouched.
echo "Installing content ..."
rm -rf "${TARGET_DIR}"
mkdir -p "${TARGET_DIR}"
mv "${EXTRACTED_DIR}/7-things" "${TARGET_DIR}/"
mv "${EXTRACTED_DIR}/data.yaml" "${TARGET_DIR}/"

echo "Done. Content ${VERSION} installed to ${TARGET_DIR}"
