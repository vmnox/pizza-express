REGISTRY_URL = vnox91
APP_NAME = pizza-express
APP_VERSION = v0.0.1
APP_IMAGE = $(REGISTRY_URL)/$(APP_NAME):$(APP_VERSION)

build:
	ansible-playbook -i localhost, ansible/playbooks/main.yaml -e app_dir="${PWD}"
