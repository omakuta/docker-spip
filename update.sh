#!/bin/bash
set -euo pipefail

declare -A spipVersions=(
  [0]='2.1'
  [1]='3.0'
  [2]='3.1'
  [3]='3.2'
)
declare -A phpVersions=(
  [2.1]='5.6'
	[3.0]='5.6'
  [3.1]='7.1'
	[3.2]='7.1'
)
declare -A spipPackages=(
  [2.1]='2-1.30'
	[3.0]='3.0.27'
  [3.1]='3.1.8'
	[3.2]='3.2.1'
)
declare -A mysqlPackages=(
	[2.1]='mysqli'
  [3.0]='mysql'
  [3.1]='mysqli'
  [3.2]='mysqli'
)

for spipVersion in "${spipVersions[@]}"; do
  mkdir -p "./${spipVersion}"

  (
    set -x

    sed -r \
      -e 's!%%PHP_VERSION%%!'"${phpVersions[$spipVersion]}"'!g' \
      -e 's!%%SPIP_VERSION%%!'"${spipVersion}"'!g' \
      -e 's!%%SPIP_PACKAGE%%!'"${spipPackages[$spipVersion]}"'!g' \
      -e 's!%%MYSQL_PACKAGE%%!'"${mysqlPackages[$spipVersion]}"'!g' \
      "Dockerfile.template" > "./${spipVersion}/Dockerfile"

    cp -a ./docker-entrypoint.sh "./${spipVersion}/docker-entrypoint.sh"
    chmod +x "./${spipVersion}/docker-entrypoint.sh"
  )
done
