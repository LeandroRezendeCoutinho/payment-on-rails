class Client < ApplicationRecord
  UUID_REGEX = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/

  validates :client_id, :public_key, :private_key, presence: true, format: { with: UUID_REGEX }
end
