#!/bin/sh
cp -a laradock_env/. laradock
pushd laradock
docker-compose up -d apache2 mysql phpmyadmin workspace
docker-compose exec -u laradock workspace composer create-project --prefer-dist laravel/laravel .
docker-compose exec -u laradock workspace composer install
docker-compose exec -u laradock workspace php artisan migrate
docker-compose exec -u laradock workspace composer require laravel/breeze --dev
docker-compose exec -u laradock workspace php artisan breeze:install
docker-compose exec -u laradock workspace npm install
docker-compose exec -u laradock workspace npm run dev
docker-compose exec -u laradock workspace php artisan migrate
popd
