FactoryBot.define do
  factory :payment do
    status { 'pending' }
    capture { true }
    order_id { 1 }
    payment_type { 'credit' }
    source_type { 'card' }
    amount_cents { 100 }
    client
    integration
  end
end
