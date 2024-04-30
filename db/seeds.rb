# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

client1 = ClientService.new.create_new_client
client1.name = "Client Teste 1"
client1.save

client2 = ClientService.new.create_new_client
client2.name = "Client Teste 2"
client2.save

integration_config = {
  provider: {
    name: "Local",
    baseUrl: "https://localhost:3500",
    payment_path: "/payments",
    auth_path: "/auth",
    auth_method: "POST",
    credentials: {
      user: "user",
      password: "password"
    }
  },
  mapping: [
    {
      from: "amount",
      to: "amount"
    },
    {
      from: "capture",
      to: "capture"
    },
    {
      from: "status",
      to: "status"
    },
    {
      from: "order_id",
      to: "order_id"
    },
    {
      from: "payment_type",
      to: "payment_type"
    },
    {
      from: "source_type",
      to: "source_type"
    }
  ]
}

integration1 = Integration.new
integration1.name = "Integration Teste 1"
integration1.client = client1
integration1.config = integration_config
integration1.save

integration2 = Integration.new
integration2.name = "Integration Teste 2"
integration2.client = client2
integration2.config = integration_config
integration2.save
