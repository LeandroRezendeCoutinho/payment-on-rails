Hutch::Config.set(:mq_host, ENV['RABBITMQ_HOST'])
Hutch::Config.set(:mq_port, ENV['RABBITMQ_PORT'])
Hutch::Config.set(:mq_username, ENV['RABBITMQ_USER'])
Hutch::Config.set(:mq_password, ENV['RABBITMQ_PASSWORD'])

# Hutch::Logging.logger = Rails.logger
