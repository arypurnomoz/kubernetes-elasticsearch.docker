#!/bin/bash

/discovery --namespace="${NAMESPACE}" --selector="${SELECTOR}" >> /tmp/elasticsearch.yml

exec /docker-entrypoint.sh elasticsearch
