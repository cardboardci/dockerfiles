.DEFAULT_GOAL:=help

DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: help
help: ## This help text.
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Docker

.PHONY: apt

apt-% : ; ## Upgrades the apt deps
	docker run \
		--rm \
		--user=root \
		--entrypoint="" \
		-e DEBIAN_FRONTEND=noninteractive \
		-v "$(DIR)":/workspace \
		--workdir=/workspace \
		cardboardci/ci-core:latest bash tools/apt.bash $*

npm-% : ; ## Upgrades the npm deps
	docker run \
		--rm \
		--user=root \
		--entrypoint="" \
		-e DEBIAN_FRONTEND=noninteractive \
		-v "$(DIR)":/workspace \
		--workdir=/workspace \
		node:latest bash tools/npm.bash $*

gem-% : ; ## Upgrades the gem deps
	docker run \
		--rm \
		--user=root \
		--entrypoint="" \
		-e DEBIAN_FRONTEND=noninteractive \
		-v "$(DIR)":/workspace \
		--workdir=/workspace \
		ruby:latest bash tools/gem.bash $*

luarocks-% : ; ## Upgrades the lua deps
	docker run \
		--rm \
		--user=root \
		--entrypoint="" \
		-e DEBIAN_FRONTEND=noninteractive \
		-v "$(DIR)":/workspace \
		--workdir=/workspace \
		ubuntu:latest bash tools/luarocks.bash $*
