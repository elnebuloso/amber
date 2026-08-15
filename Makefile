.PHONY: help build up down test

help: ## Show the available targets
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "%-8s %s\n", $$1, $$2}'

build: ## Build the image as amber:dev
	docker build --tag amber:dev .

up: ## Start 8080 plain, 8081 markdown, 8082 markdown with a custom stylesheet
	docker compose up --build --remove-orphans -d

down: ## Stop the site
	docker compose down --remove-orphans

test: build ## Run the smoke test against a freshly built image
	./scripts/smoke.sh amber:dev
