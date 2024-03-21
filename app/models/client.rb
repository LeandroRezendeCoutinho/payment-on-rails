# == Schema Information
#
# Table name: clients
#
#  id          :bigint           not null, primary key
#  name        :string
#  private_key :string
#  public_key  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :string
#
class Client < ApplicationRecord
  UUID_REGEX = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/
  validates :name, presence: true
  validates :client_id, :public_key, :private_key, presence: true, format: { with: UUID_REGEX }
  has_many :payments, dependent: :destroy, foreign_key: true
  has_many :integrations, dependent: :destroy, foreign_key: true
end
