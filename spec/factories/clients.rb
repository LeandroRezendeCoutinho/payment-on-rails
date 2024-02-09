FactoryBot.define do
  factory :client do
    sequence(:id) { |n| n }
    client_id { '17663c88-11e5-45c4-86be-4f56f47c694a' }
    public_key { '7972cdfb-e088-499d-a3d7-ba37512697ed' }
    private_key { '0f5efa78-4997-43e4-a5fe-e13f03c529b9' }
  end
end
