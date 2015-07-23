#!/bin/bash

/discovery --namespace="${NAMESPACE}" --selector="${SELECTOR}" >> /usr/share/elasticsearch/config/elasticsearch.yml

exec /docker-entrypoint.sh elasticsearch
