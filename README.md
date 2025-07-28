# 1: Overview

This is a sample project with Laravel Sail

# 2: General Setup Guide

## 2-1: Install php & composer

```zsh
brew install php
brew install composer
```

## 2-2: Create a project

```zsh
composer create-project laravel/laravel sample-laravel-sail
```

## 2-3: Install Sail

```zsh
php artisan sail:install
```

## 2-4: Boot app

General command

```zsh
./vendor/bin/sail up -d
```

### The following is a tip about running a shortcut command to boot sail app

Add the following shortcut in `~/.zshrc`.

```zsh
alias sail
```

Please run the following command to make the added shortcut effective in the current terminal. (If you restart or open new session, you don't need to run the following command)

```zsh
source ~/.zshrc
```

After adding the above command, you can boot app with the added shortcut as follows.

```zsh
sail up -d
```
