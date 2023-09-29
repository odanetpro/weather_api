# README

This is an API for weather statistics.

Gets statistics from accuweather.com (every hour the temperature for the last 24 hours, every 15 minutes the current temperature ), stores it locally and gives it in different slices.

The API contains the following endpoints:

* v1/health - API status
* v1/weather/current - current temperature
* v1/weather/historical - hourly temperature for the last 24 hours
* v1/weather/historical/max - maximum temperature in the last 24 hours
* v1/weather/historical/min - minimum temperature in the last 24 hours
* v1/weather/historical/avg - average temperature over the last 24 hours
* v1/weather/by_time - temperature closest to the passed timestamp parameter

Technologies and dependencies:

* Ruby 3.2.2, Rails 7.0.8
* Database: Redis
* Background jobs: Sidekiq
* HTTP requests: RestClient
* Sheduler: Rufus

Tests:

* Rspec, VCR
