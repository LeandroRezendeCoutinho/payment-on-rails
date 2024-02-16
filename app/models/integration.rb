# == Schema Information
#
# Table name: integrations
#
#  id         :bigint           not null, primary key
#  name       :string
#  config     :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Integration < ApplicationRecord
  validates :name, presence: true
  validates_with JsonSchemaValidator, on: [:create, :update]
end
