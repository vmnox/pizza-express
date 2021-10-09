#!/bin/bash

set -xeof pipefail

# Please make sure to specify the following before running:
# export REGISTRY_URL=[...]

# Prerequisites:
# 1) docker 20.10.7
# 2) ansible-version ~2.9.6 with Python interpreter ~3.8.10 (tested)
# 3) runtime user needs to be in a docker group

BASEDIR="$(readlink -f $(dirname $0))"
REGISTRY_URL="${REGISTRY_URL:-vnox91}"
APP_NAME="pizza-express"
APP_TAG=${PIZZA_APP_TAG:-"v0.0.1"}


# the following will execute application tests, build the container, tag and push it
# into REGISTRY_URL/APP_NAME:APP_TAG location
export ANSIBLE_CONFIG="${BASEDIR}/ansible.cfg"
ansible-playbook -i "${BASEDIR}/ansible/inventory/hosts.ini" \
    "${BASEDIR}/ansible/playbooks/main.yaml" -e app_dir="${BASEDIR}" \
    -e app_image="${REGISTRY_URL}/${APP_NAME}" \
    -e app_tag="${APP_TAG}" -e USER="${UID}"


# Pizza-express Chart deployment:
# Prerequisites:
# 1) kind cluster
# 2) helm

# export DOMAIN=[...]
# export REGISTRY_URL=[...]
# export PIZZA_IMAGE="${REGISTRY_URL}/pizza-express"
# helm install pizza-express ./Charts/pizza-express \
#    --set image.repository="${PIZZA_IMAGE}" \
#    --set "ingress.hosts[0].host=${DOMAIN},ingress.hosts[0].paths[0].path=/"

# Bonus: application log shipping to a dedicated central file located on the node with fluentd (ok for a single node cluster, not ok for else...)
# kubectl apply -f fluentd/fluentd-daemonset.yaml
