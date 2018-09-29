# Cart API

Simple Shopping Cart API

## Status

[![Build Status](https://api.travis-ci.org/bladebhs/cart_api.svg?branch=master)](http://travis-ci.org/bladebhs/cart_api) [![Maintainability](https://api.codeclimate.com/v1/badges/b8582bf6b140d26dd2cf/maintainability)](https://codeclimate.com/github/bladebhs/cart_api/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/b8582bf6b140d26dd2cf/test_coverage)](https://codeclimate.com/github/bladebhs/cart_api/test_coverage)

## Requirements

* Ruby 2.5.1
* Some database to store products (tested on PostgreSQL 10)

## Setup

* Install required ruby version (`rvm install 2.5.1` or `rbenv install 2.5.1`)
* Install Bundler `gem install bundler`
* Copy `config/database.yml.example` to `config/database.yml` and configure the database
* Run `./bin/setup`

## How to use

The simpliest way is to use [http](https://httpie.org/) command.

``` bash
http POST https://rails-cart-api.herokuapp.com/api/cart product_id=1 quantity=5
```
