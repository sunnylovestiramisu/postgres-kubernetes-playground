#!/bin/bash

kubectl cnpg pgbench \
  --job-name pgbench-init \
  postgres-performance-us-central1 \
  -- --initialize --scale 32
