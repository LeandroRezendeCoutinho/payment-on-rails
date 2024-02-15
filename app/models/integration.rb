class Integration < ApplicationRecord
  validates :name, presence: true
  validates_with JsonSchemaValidator, on: [:create, :update]
end
