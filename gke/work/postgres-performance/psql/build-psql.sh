#!/bin/bash

docker build -t psql:latest .
docker tag psql:latest us-central1-docker.pkg.dev/songsunny-joonix/postgres/psql:latest
docker push us-central1-docker.pkg.dev/songsunny-joonix/postgres/psql:latest
