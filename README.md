# README

* Payment on Rails
- A Rails app for accepting payments

* Ruby version
- 3.3.0

* System dependencies
- PostgreSQL
- Redis
- AWS SQS

* How to run the test suite
- `bundle exec rspec`

* Services (job queues, cache servers, search engines, etc.)
- AWS SQS
- Sidekiq

* Deployment 
- Github actions
- AWS

## Architecture
![Architecture diagram](./images/architecture.png)

### AWS localstack
- Configure localstack
    - `aws configure --endpoint-url=http://localhost:4566`
        - AWS Access Key ID [None]: 00000000000000000000
        - AWS Secret Access Key [None]: 00000000000000000000
        - Default region name [None]: us-east-1
- Configure AWS SQS
    - `aws sqs create-queue --queue-name charge --endpoint-url=http://localhost:4566`

#### AWS reference
- https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/sqs-example-send-messages.html