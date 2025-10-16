#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <k8s hostname>"
  exit 1
fi

server="https://$1:16443"
secretName="github-actions-secret"
secretNamespace="cijug"

ca=$(kubectl get -n "$secretNamespace" secret/$secretName -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get -n "$secretNamespace" secret/$secretName -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get -n "$secretNamespace" secret/$secretName -o jsonpath='{.data.namespace}' | base64 --decode)

echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: default-context
  context:
    cluster: default-cluster
    namespace: ${namespace}
    user: default-user
current-context: default-context
users:
- name: default-user
  user:
    token: ${token}
"
