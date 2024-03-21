# == Schema Information
#
# Table name: integrations
#
#  id         :bigint           not null, primary key
#  config     :json
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint
#
# Indexes
#
#  index_integrations_on_client_id  (client_id)
#
FactoryBot.define do
  factory :integration do
    name { "Integration Name" }
    config do
      {
        "provider" => {
          "name" => "Provider Name",
          "baseUrl" => "http://localhost:3000",
          "payment_path" => "/payments",
          "auth_path" => "",
          "auth_method" => "post",
          "credentials" => { "user" => "user", "password" => "password" }
        },
        "mapping" => [
          { "from" => "from", "to" => "to", "function" => "function" }
        ]
      }
    end
    client
  end
end
