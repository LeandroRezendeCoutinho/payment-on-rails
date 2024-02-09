# README

## Payment on Rails
- A Rails app for accepting payments

### Ruby version
- 3.3.0

### Rails version
- 7.1.3

### Application dependencies
- pg
- redis
- sidekiq
- hutch
- enumerize
- faraday
- rspec
- factory_bot
- money
- simple_cov
- webmock
- rubocop

### Service dependencies
- PostgreSQL
- Redis
- RabbitMQ

### Services (queues)
- Sidekiq
- Hutch 

### Deployment 
- Github actions
- AWS

### How to run the app
- `bundle exec rails s -b '0.0.0.0'`

### How to run the sidekiq
- `bundle exec sidekiq config/sidekiq.yml`

### How to run the hutch
- `bundle exec hutch`

### How to run the test suite
- `bundle exec rspec`

## Architecture
![Architecture diagram](./images/architecture.jpg)

## Code coverage
![Code coverage](./images/coverage.png)