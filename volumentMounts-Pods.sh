#!/bin/bash
if [ -z "$1" ]
then
      echo "Namespace is NULL"
else
      if [ "all" = "$1" ]; then
          kubectl get pods --all-namespaces -o json | jq -r '.items[] | {name: .metadata.name, ContainerVolume: .spec.containers[].volumeMounts, ExternalVolum: .spec.volumes}'
      else
          kubectl get pods -n $1 -o json | jq -r '.items[] | {name: .metadata.name, ContainerVolume: .spec.containers[].volumeMounts, ExternalVolum: .spec.volumes}'
      fi
fi
