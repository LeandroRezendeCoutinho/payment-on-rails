# frozen_string_literal: true

Aws.config.update(
  region: ENV['AWS_REGION'], # LocalStack
  endpoint: ENV['SQS_QUEUE_URL'], # LocalStack endpoint
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
)
