.PHONY: help build up down logs clean test lint build-prod deploy-local

help:
	@echo "╔═══════════════════════════════════════════════════════════╗"
	@echo "║        IF-EDUprime Docker & CI/CD Command Help            ║"
	@echo "╚═══════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "Docker Commands:"
	@echo "  make build              - Build Docker image"
	@echo "  make build-prod         - Build production image"
	@echo "  make up                 - Start containers (development)"
	@echo "  make down               - Stop containers"
	@echo "  make logs               - View container logs"
	@echo "  make shell              - Access container shell"
	@echo ""
	@echo "Development Commands:"
	@echo "  make lint               - Run linting checks"
	@echo "  make test               - Run tests"
	@echo "  make clean              - Remove containers and images"
	@echo ""
	@echo "Deployment Commands:"
	@echo "  make deploy-local       - Deploy locally"
	@echo "  make deploy-dev         - Deploy to dev environment"
	@echo ""

build:
	docker build -t eduprime:dev .
	@echo "✓ Development image built successfully"

build-prod:
	docker build -t eduprime:latest -t eduprime:$$(date +%Y%m%d) .
	@echo "✓ Production image built successfully"

up:
	docker-compose up -d
	@echo "✓ Containers started"
	@echo "  Access the application at: http://localhost"

down:
	docker-compose down
	@echo "✓ Containers stopped"

logs:
	docker-compose logs -f

shell:
	docker-compose exec web sh

test:
	@echo "Running tests..."
	@docker-compose exec -T web wget --quiet --tries=1 --spider http://localhost/ || exit 1
	@echo "✓ Health check passed"

lint:
	@echo "Running linters..."
	@docker run --rm -i hadolint/hadolint < Dockerfile
	@echo "✓ Dockerfile linting passed"

clean:
	docker-compose down -v
	docker rmi eduprime:dev || true
	docker rmi eduprime:latest || true
	@echo "✓ Cleanup complete"

restart:
	make down
	make up

ps:
	docker-compose ps

push-registry:
	docker login $(CI_REGISTRY)
	docker tag eduprime:latest $(CI_REGISTRY)/$(CI_PROJECT_PATH):latest
	docker push $(CI_REGISTRY)/$(CI_PROJECT_PATH):latest
	@echo "✓ Image pushed to registry"

validate-compose:
	docker-compose config
	@echo "✓ docker-compose.yml is valid"

validate-ci:
	@echo "Validating GitLab CI configuration..."
	@echo "Run: gitlab-runner verify --config gitlab-runner-config.toml"

.DEFAULT_GOAL := help
