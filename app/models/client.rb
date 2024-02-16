# == Schema Information
#
# Table name: clients
#
#  id          :bigint           not null, primary key
#  client_id   :string
#  public_key  :string
#  private_key :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Client < ApplicationRecord
  UUID_REGEX = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/

  validates :client_id, :public_key, :private_key, presence: true, format: { with: UUID_REGEX }
end
