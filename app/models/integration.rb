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
class Integration < ApplicationRecord
  validates :name, presence: true
  validates_with JsonSchemaValidator, on: [:create, :update]
  has_many :payments, dependent: :destroy
  belongs_to :client
end
