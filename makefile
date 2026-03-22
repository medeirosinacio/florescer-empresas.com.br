#!/usr/bin/make

.DEFAULT_GOAL := help

TAILWIND_VERSION := v4.2.2

setup: ## Setup the project
	make check-docker
	docker stop jekyll-bootstrap > /dev/null 2>&1 || true
	if [ "$(shell uname -m)" = "arm64" ]; then make setup-arm; else make setup-x86; fi

setup-x86: ## Setup the project for x86
	docker run --rm \
	  --name jekyll-bootstrap \
	  -v ./:/app \
	  -w /app \
	  --dns 8.8.8.8 \
	  -p 80:4000 \
	  -p 4000:4000 \
	  -p 35729:35729 \
	  ruby:2.7 \
	  /bin/sh -c "\
	    curl -skLO https://github.com/tailwindlabs/tailwindcss/releases/download/$(TAILWIND_VERSION)/tailwindcss-linux-x64 && \
	    chmod +x tailwindcss-linux-x64 && \
	    bundle install --path=./.gem-cache && \
	    ./tailwindcss-linux-x64 -i assets/css/input.css -o assets/css/output.css --minify && \
	    (./tailwindcss-linux-x64 -i assets/css/input.css -o assets/css/output.css --watch &) && \
	    bundle exec jekyll serve --force_polling --host 0.0.0.0 --livereload"

setup-arm: ## Setup the project for ARM
	docker run --rm \
	  --name jekyll-bootstrap \
	  -v ./:/app \
	  -w /app \
	  --dns 8.8.8.8 \
	  -p 80:4000 \
	  -p 4000:4000 \
	  -p 35729:35729 \
	  -e RUBYOPT="-W0" \
	  arm64v8/ruby:3.1 \
	  /bin/sh -c "\
	    curl -skLO https://github.com/tailwindlabs/tailwindcss/releases/download/$(TAILWIND_VERSION)/tailwindcss-linux-arm64 && \
	    chmod +x tailwindcss-linux-arm64 && \
	    bundle install --path=./.gem-cache && \
	    ./tailwindcss-linux-arm64 -i assets/css/input.css -o assets/css/output.css --minify && \
	    (./tailwindcss-linux-arm64 -i assets/css/input.css -o assets/css/output.css --watch &) && \
	    bundle exec jekyll serve --force_polling --host 0.0.0.0 --livereload"

check-docker: ## Check if Docker is installed
	@docker --version > /dev/null || (echo "Docker is not installed. Please install Docker first." && exit 1)

##@ Docs

help: ## Print the makefile help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
