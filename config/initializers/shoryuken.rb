# config/initializers/shoryuken.rb

Shoryuken.configure_server do |config|
  config.sqs_client = Aws::SQS::Client.new(
    region: ENV['AWS_REGION'],
    endpoint: ENV['SQS_QUEUE_URL'],
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  )
end

Shoryuken::Client.sqs.create_queue(queue_name: ENV['SQS_QUEUE_NAME'])
Shoryuken.sqs_client_receive_message_opts = { wait_time_seconds: 0 }
