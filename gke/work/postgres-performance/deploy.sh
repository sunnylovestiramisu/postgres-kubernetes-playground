#/usr/bin/env bash
#
# Script to deploy two GKE clusters for CloudNativePG demonstration
# purposes.

# Create the GCS Bucket in the us-central1 region
bucket1_name="gs://postgres-performance-us-central1"
bucket1_region="us-central1"
gsa1_name="postgres-performance-user"
gcloud storage buckets create "$bucket1_name" --location="$bucket1_region"
gcloud iam service-accounts create postgres-performance-user --project="songsunny-joonix"
gcloud storage buckets add-iam-policy-binding "gs://postgres-performance-us-central1" \
    --member "serviceAccount:postgres-performance-user@songsunny-joonix.iam.gserviceaccount.com" \
    --role "roles/storage.objectUser"

gcloud storage buckets add-iam-policy-binding "gs://postgres-performance-us-central1" \
    --member "serviceAccount:postgres-performance-user@songsunny-joonix.iam.gserviceaccount.com" \
    --role "roles/storage.legacyBucketReader"

# Create the GCS Bucket in the TODO region
bucket2_name="gs://postgres-performance-TODO"
bucket2_region="TODO"
#gcloud storage buckets create "$bucket2_name" --location="$bucket2_region"

# Create the GKE cluster in the us-central1 region
cluster1_name="postgres-performance-us-central1"
cluster1_region="us-central1"
gcloud container clusters create "$cluster1_name" --region "$cluster1_region" --num-nodes=1 --cluster-version=1.27 --machine-type=n2-standard-4 --workload-pool="songsunny-joonix.svc.id.goog"
gcloud container node-pools create postgres --num-nodes=1 --cluster="$cluster1_name" --region "$cluster1_region" --node-locations us-central1-a,us-central1-b,us-central1-c --node-labels=workload=postgres --node-taints=workload=postgres:NoExecute --machine-type=c3-standard-8
gcloud iam service-accounts add-iam-policy-binding "${gsa1_name}@songsunny-joonix.iam.gserviceaccount.com" \
    --role roles/iam.workloadIdentityUser \
    --member "serviceAccount:songsunny-joonix.svc.id.goog[default/${cluster1_name}]"

# Deploy VolumeSnapshotClass
kubectl apply -f snapshot-class.yaml

# Create the GKE cluster in the TODO region
cluster2_name="postgres-performance-TODO"
cluster2_region="TODO"
#gcloud container clusters create "$cluster2_name" --region "$cluster2_region" --num-nodes=1 --cluster-version=1.27 --machine-type=n2-standard-4 --workkload-pool="songsunny-joonix.svc.id.goog"
#gcloud container node-pools create postgres --num-nodes=1 --cluster="$cluster2_name" --region "$cluster2_region" --node-labels=workload=postgres --machine-type=c3-standard-8

