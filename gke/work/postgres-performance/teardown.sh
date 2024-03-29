#!/usr/bin/env bash
#
# Script to remove the two GKE clusters that had been
# previously set up for CloudNativePG demonstration purposes.

# Delete the primary cluster
gcloud container clusters delete postgres-performance-us-central1 --region=us-central1

# Delete the secondary cluster
# gcloud container clusters delete postgres-performance-TODO --region=TODO

# Delete the primary GCS bucket
gcloud storage rm --recursive gs://postgres-performance-us-central1

# Delete the secondary GCS bucket
# gcloud storage rm --recursive gs://postgres-performance-TODO
