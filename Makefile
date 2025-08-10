# Laravel Sail Makefile

# Default target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make migrate       - Run database migrations"
	@echo "  make migrate-fresh - Fresh migration with seed"
	@echo "  make seed          - Run database seeders"
	@echo "  make cache-clear   - Clear application cache"
	@echo "  make config-clear  - Clear config cache"
	@echo "  make route-clear   - Clear route cache"
	@echo "  make view-clear    - Clear view cache"
	@echo "  make optimize      - Optimize application"
	@echo "  make tinker        - Start Tinker REPL"
	@echo "  make test          - Run PHPUnit tests"
	@echo "  make queue-work    - Start queue worker"
	@echo "  make up            - Start Docker containers"
	@echo "  make down          - Stop Docker containers"
	@echo "  make restart       - Restart Docker containers"

# Docker commands
.PHONY: up down restart
up:
	./vendor/bin/sail up -d

down:
	./vendor/bin/sail down

restart:
	./vendor/bin/sail restart

# Database commands
.PHONY: migrate migrate-fresh seed
migrate:
	./vendor/bin/sail php artisan migrate

migrate-fresh:
	./vendor/bin/sail php artisan migrate:fresh --seed

seed:
	./vendor/bin/sail php artisan db:seed

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
