# Laravel Sail Makefile

# Default target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make migrate                    - Run database migrations"
	@echo "  make migrate-fresh              - Fresh migration with seed"
	@echo "  make seed                       - Run database seeders"
	@echo "  make seed-part [table_name]     - Seed a specific table"
	@echo "  make delete-data                - Delete all data from the database"
	@echo "  make cache-clear                - Clear application cache"
	@echo "  make config-clear               - Clear config cache"
	@echo "  make route-clear                - Clear route cache"
	@echo "  make view-clear                 - Clear view cache"
	@echo "  make optimize                   - Optimize application"
	@echo "  make tinker                     - Start Tinker REPL"
	@echo "  make test                       - Run PHPUnit tests"
	@echo "  make queue-work                 - Start queue worker"
	@echo "  make ps                         - Check Docker container status"
	@echo "  make build                      - Build Docker containers"
	@echo "  make up                         - Start Docker containers"
	@echo "  make down                       - Stop Docker containers"
	@echo "  make restart                    - Restart Docker containers"
	@echo "  make exec [name]                - Execute bash in a running container"
	@echo "  make composer-install           - Install composer dependencies"
	@echo "  make composer-update            - Update composer dependencies"
	@echo "  make composer-outdated          - Show outdated composer packages"
	@echo "  make composer-version [package] - Show specific package version"
	@echo "  make composer-require [package] - Require new composer package"
	@echo "  make npm-install                - Install npm dependencies"
	@echo "  make npm-run [script]           - Run npm script"
	@echo "  make npm-list                   - List npm packages"
	@echo "  make npm-outdated               - Show outdated npm packages"
	@echo "  make npm-update                 - Update npm packages"
	@echo "  make npm-version [package]      - Show specific npm package version"

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

# composer commands
.PHONY: composer-install composer-update composer-outdated composer-version composer-require
composer-install:
	./vendor/bin/sail composer install

composer-update:
	./vendor/bin/sail composer update

composer-outdated:
	./vendor/bin/sail composer outdated

composer-version:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make composer-version [package_name]"; \
		echo "Example: make composer-version laravel/sail"; \
	else \
		./vendor/bin/sail composer show $(filter-out $@,$(MAKECMDGOALS)); \
	fi

composer-require:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make composer-require [package_name]"; \
		echo "Example: make composer-require laravel/sail"; \
	else \
		./vendor/bin/sail composer require $(filter-out $@,$(MAKECMDGOALS)); \
	fi

# artisan commands
# npm commands
.PHONY: npm-install npm-run npm-list npm-outdated npm-update npm-version
npm-install:
	./vendor/bin/sail npm install

npm-run:
	./vendor/bin/sail npm run $(filter-out $@,$(MAKECMDGOALS

npm-list:
	./vendor/bin/sail npm list

npm-outdated:
	./vendor/bin/sail npm outdated

npm-update:
	./vendor/bin/sail npm update

npm-version:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make npm-version [package_name]"; \
		echo "Example: make npm-version vite"; \
	else \
		./vendor/bin/sail npm list $(filter-out $@,$(MAKECMDGOALS)); \
	fi
