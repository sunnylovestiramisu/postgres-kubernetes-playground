#/usr/bin/env bash
#
# Script to deploy CloudNative PG resources into a Kubernetes cluster

kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.21/releases/cnpg-1.21.0.yaml

# TODO Wait for operator and webhook to be running
sleep 30

kubectl apply -f cloudnative-pg/postgres-performance-us-central1.yaml
