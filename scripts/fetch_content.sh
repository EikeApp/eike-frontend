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

echo "Downloading version ${VERSION} ..."
curl -L "https://github.com/EikeApp/eike-content/archive/refs/tags/${VERSION}.zip" -o "${ZIP_FILE}"

echo "Unzipping ..."
unzip -q "${ZIP_FILE}"

# echo "Extracting content ..."
# mkdir -p eike_content
# mv "${EXTRACTED_DIR}/7-things" eike_content/
# mv "${EXTRACTED_DIR}/data.yaml" eike_content/
#
# # if command -v yq &> /dev/null; then
# #   echo "Converting YAML to JSON"
# #   yq -o=json eike_content/data.yaml > eike_content/data.json
# #   rm -f eike_content/data.yaml
# # else
# #   echo "Could not convert YAML to JSON due to missing dependency on yq."
# #   echo "Consider installing yq using Homebrew for example."
# #   exit 1
# # fi
#
# echo "Cleaning old content ..."
# rm -rf "${TARGET_DIR}"
# mkdir -p "${TARGET_DIR}"
#
# echo "Moving new content"
# mv eike_content/* "${TARGET_DIR}/"
# mv eike_content/.version "${TARGET_DIR}/"
# # rmdir eike_content
#
# echo "Cleaning up ..."
# # rm -rf "${ZIP_FILE}" "${EXTRACTED_DIR}"
#
# echo "Done!"
