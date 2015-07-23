#!/bin/bash

/discovery --namespace="${NAMESPACE}" --selector="${SELECTOR}" >> /usr/share/elasticsearch/conf/elasticsearch.yml

exec /docker-entrypoint.sh elasticsearch
