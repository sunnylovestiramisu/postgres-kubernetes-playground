#!/usr/bin/env bash

usage() {
cat <<EOF
This scripts facilitates the restoration of a CNPG cluster.
It finds the last two volume snapshots and generates the
restored cluster manifest from them.

Note this script assumes that there is nothing else
backed up in this cluster.

$0

EOF
exit 1
}

mangle() {
sed \
  -e "s/@@SNAPSHOT_VOLUME@@/${SNAPSHOT_VOLUME}/g" \
  -e "s/@@SNAPSHOT_WAL@@/${SNAPSHOT_WAL}/g" \
  ${1} > ${2}
}

#TOP=$(cd "$(dirname "$0")"; pwd)

# Find most recent snapshots
snaps="$(kubectl get volumesnapshots | grep true |  tail -2 | awk '{print $1}' | tr '\n' ' ')"
read -r SNAPSHOT_VOLUME SNAPSHOT_WAL <<< "$snaps"

# Manifest for the restore cluster
mangle postgres-performance-us-central1-restore.yaml.in postgres-performance-us-central1-restore.yaml

kubectl apply -f postgres-performance-us-central1-restore.yaml
