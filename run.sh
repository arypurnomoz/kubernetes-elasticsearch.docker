#!/bin/bash

set -e

if [ ! "$NAMESPACE" ]; then 
  >&2 echo \$NAMESPACE variable required
  exit 1  
fi

if [ ! "$SELECTOR" ]; then 
  >&2 echo \$SELECTOR variable required
  exit 1  
fi

PEER_NODES=$(curl -s \
  --cacert /run/secrets/kubernetes.io/serviceaccount/ca.crt \
  -H "Authorization: Bearer `cat /run/secrets/kubernetes.io/serviceaccount/token`" \
  https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/$NAMESPACE/pods?labelSelector=$SELECTOR \
    | grep podIP | grep -v `hostname -i` | awk '{print $2}'|sed 's/"//g' | sed 's/,//' | xargs echo)

echo peer $PEER_NODES

CONFIG=/usr/share/elasticsearch/config/elasticsearch.yml

echo "discovery.zen.ping.unicast.hosts: [$PEER_NODES]" >> $CONFIG 
echo "discovery.zen.ping.multicast.enabled: false" >> $CONFIG 
echo "network.publish_host: `hostname -i`" >> $CONFIG 

exec /docker-entrypoint.sh elasticsearch $@
