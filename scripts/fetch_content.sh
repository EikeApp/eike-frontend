#!/bin/zsh

set -euo pipefail

VERSION="${1:-${VERSION:-}}"

if [[ -z "${VERSION}" ]]; then
  echo "No version provided!"
  echo "Usage: $0 <version> OR VERSION=... $0"
  exit 1
fi

ZIP_FILE="content.zip"
EXTRACTED_DIR="eike-content-${VERSION}"
TARGET_DIR="../packages/eike_app/assets/content"

rm -rf ${TARGET_DIR:?}/

echo "Downloading version ${VERSION} ..."
curl -L "https://github.com/EikeApp/eike-content/archive/refs/tags/${VERSION}.zip" -o "${ZIP_FILE}"

echo "Unzipping ..."
unzip -q "${ZIP_FILE}"

echo "Extracting content ..."
mkdir -p eike_content
mv "${EXTRACTED_DIR}/7-things" eike_content/
mv "${EXTRACTED_DIR}/data.yaml" eike_content/

mkdir -p "${TARGET_DIR}"
mv eike_content/* ${TARGET_DIR}/

rm -rf eike_content/
rm -rf "${EXTRACTED_DIR}"
rm "${ZIP_FILE}"
