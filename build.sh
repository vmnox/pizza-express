#!/bin/bash

set -eof pipefail

REGISTRY_URL="${REGISTRY_URL:-vnox91}"
APP_NAME="pizza-express"
APP_TAG=${PIZZA_APP_TAG:-"v0.0.1"}

ansible-playbook -i localhost, ansible/playbooks/main.yaml -e app_dir="${PWD}" -e app_image="${REGISTRY_URL}/${APP_NAME}" -e app_tag="${APP_TAG}"
