# Laravel Sail Makefile

# Default target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make migrate       - Run database migrations"
	@echo "  make migrate-fresh - Fresh migration with seed"
	@echo "  make seed          - Run database seeders"
	@echo "  make seed-part [table_name] - Seed a specific table"
	@echo "  make delete-data"  - Delete all data from the database"
	@echo "  make cache-clear   - Clear application cache"
	@echo "  make config-clear  - Clear config cache"
	@echo "  make route-clear   - Clear route cache"
	@echo "  make view-clear    - Clear view cache"
	@echo "  make optimize      - Optimize application"
	@echo "  make tinker        - Start Tinker REPL"
	@echo "  make test          - Run PHPUnit tests"
	@echo "  make queue-work    - Start queue worker"
	@echo "  make ps            - Check Docker container status"
	@echo "  make build					- Build Docker containers"
	@echo "  make up            - Start Docker containers"
	@echo "  make down          - Stop Docker containers"
	@echo "  make restart       - Restart Docker containers"
	@echo "  make exec [name]   - Execute bash in a running container"

# Docker commands
.PHONY: ps build up down restart exec
ps:
	./vendor/bin/sail ps

build:
	./vendor/bin/sail build

up:
	./vendor/bin/sail up -d

down:
	./vendor/bin/sail down

restart:
	./vendor/bin/sail restart

exec:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make exec [container_name]"; \
		echo "Example: make exec laravel.test"; \
	else \
		docker-compose exec -it $(filter-out $@,$(MAKECMDGOALS)) bash; \
	fi

%:
	@:

# Database commands
.PHONY: migrate migrate-fresh seed seed-part
migrate:
	./vendor/bin/sail php artisan migrate

migrate-fresh:
	./vendor/bin/sail php artisan migrate:fresh --seed

seed:
	./vendor/bin/sail php artisan db:seed

seed-part:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make seed-part [table_name]"; \
		echo "Example: make seed-part recipes"; \
	else \
		./vendor/bin/sail php artisan db:seed --class=$(filter-out $@,$(MAKECMDGOALS))TableSeeder; \
	fi

delete-data:
	./vendor/bin/sail php artisan migrate:fresh

# Cache commands
.PHONY: cache-clear config-clear route-clear view-clear optimize
cache-clear:
	./vendor/bin/sail php artisan cache:clear

config-clear:
	./vendor/bin/sail php artisan config:clear

route-clear:
	./vendor/bin/sail php artisan route:clear

view-clear:
	./vendor/bin/sail php artisan view:clear

optimize:
	./vendor/bin/sail php artisan optimize

# Development commands
.PHONY: tinker test queue-work
tinker:
	./vendor/bin/sail php artisan tinker

test:
	./vendor/bin/sail php artisan test

queue-work:
	./vendor/bin/sail php artisan queue:work
