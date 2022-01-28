#!/bin/bash
if [ -z "$1" ]
then
      echo "Namespace is NULL"
else
      if [ "all" = "$1" ]; then
            kubectl get pod -o json -A | jq -r '.items[] | {pod_name: .metadata.name, pod_ip: .status.podIP, pod_port: .spec.containers[].ports[].containerPort}'
     elif [ "smart" = "$1" ]; then
            namespaces_list=$(kubectl get namespaces -o json | jq -r '.items[].metadata.name')
            for namespace in $namespaces_list
                  do
                        kubectl get pod -o json -n $namespace | jq -r '.items[] | {pod_name: .metadata.name, pod_ip: .status.podIP, pod_port: .spec.containers[].ports[].containerPort}' > $namespace
                  done
      else
            kubectl get pod -o json -n $namespace | jq -r '.items[] | {pod_name: .metadata.name, pod_ip: .status.podIP, pod_port: .spec.containers[].ports[].containerPort}' > $namespace
      fi
fi
