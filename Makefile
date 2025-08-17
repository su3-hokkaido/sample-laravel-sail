# Laravel Sail Makefile

# Default target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  ps                         - Check Docker container status"
	@echo "  build                      - Build Docker containers"
	@echo "  up                         - Start Docker containers"
	@echo "  down                       - Stop Docker containers"
	@echo "  restart                    - Restart Docker containers"
	@echo "  exec [name]                - Execute bash in a running container"
	@echo "  migrate                    - Run database migrations"
	@echo "  migrate-fresh              - Fresh migration with seed"
	@echo "  seed                       - Run database seeders"
	@echo "  seed-part [table_name]     - Seed a specific table"
	@echo "  delete-data                - Delete all data from the database"
	@echo "  cache-clear                - Clear application cache"
	@echo "  config-clear               - Clear config cache"
	@echo "  route-clear                - Clear route cache"
	@echo "  view-clear                 - Clear view cache"
	@echo "  optimize                   - Optimize application"
	@echo "  tinker                     - Start Tinker REPL"
	@echo "  test                       - Run PHPUnit tests"
	@echo "  queue-work                 - Start queue worker"
	@echo "  composer-install           - Install composer dependencies"
	@echo "  composer-update            - Update composer dependencies"
	@echo "  composer-outdated          - Show outdated composer packages"
	@echo "  composer-version [package] - Show specific package version"
	@echo "  composer-require [package] - Require new composer package"
	@echo "  npm-install                - Install npm dependencies"
	@echo "  npm-install-package [pkg]  - Install specific npm package"
	@echo "  npm-run [script]           - Run npm script"
	@echo "  npm-list                   - List npm packages"
	@echo "  npm-outdated               - Show outdated npm packages"
	@echo "  npm-update                 - Update npm packages"
	@echo "  npm-update-package [pkg]   - Update specific npm package"
	@echo "  npm-version [package]      - Show specific npm package version"

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
.PHONY: npm-install npm-upgrade-package npm-install-package npm-run npm-list npm-outdated npm-update npm-update-package npm-version
npm-install:
	./vendor/bin/sail npm install

npm-upgrade-package:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
			echo "Usage: make npm-upgrade-package [package@version]"; \
			echo "Example: make npm-upgrade-package vite@^7.1.2"; \
			echo "Example: make npm-upgrade-package tailwindcss@^4.1.12"; \
			echo "This will update both package.json and package-lock.json"; \
	else \
			./vendor/bin/sail npm install $(filter-out $@,$(MAKECMDGOALS)); \
	fi

npm-install-package:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
			echo "Usage: make npm-install-package [package@version]"; \
			echo "Example: make npm-install-package vite@^7.1.2"; \
			echo "Example: make npm-install-package tailwindcss@^4.1.12"; \
			echo "Example: make npm-install-package vite (latest)"; \
	else \
			./vendor/bin/sail npm install $(filter-out $@,$(MAKECMDGOALS)); \
	fi

npm-run:
	./vendor/bin/sail npm run $(filter-out $@,$(MAKECMDGOALS))

npm-list:
	./vendor/bin/sail npm list

npm-outdated:
	./vendor/bin/sail npm outdated

npm-update:
	./vendor/bin/sail npm update

npm-update-package:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make npm-update [package_name]"; \
		echo "Example: make npm-update vite"; \
	else \
		./vendor/bin/sail npm update $(filter-out $@,$(MAKECMDGOALS)); \
	fi

npm-version:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make npm-version [package_name]"; \
		echo "Example: make npm-version vite"; \
	else \
		./vendor/bin/sail npm list $(filter-out $@,$(MAKECMDGOALS)); \
	fi
