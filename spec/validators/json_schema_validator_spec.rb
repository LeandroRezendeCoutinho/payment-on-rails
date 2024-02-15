# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonSchemaValidator do
  context "when schema is valid" do
    it "returns true" do
      metaschema = JSON::Validator.validator_for_name("draft4").metaschema
      expect(JSON::Validator.validate(metaschema, JsonSchemaValidator::SCHEMA)).to eq(true)
    end
  end

  context '#validate' do
    let(:valid_schema) do
      {
        "provider": {
          "name": "MyProvider",
          "baseUrl": "https://provider.example.com",
          "payment_path": "/payments",
          "auth_path": "/auth",
          "auth_method": "basic",
          "credentials": { "username": "user", "password": "password" }
        },
        "mapping": [
          { "from": "source_field", "to": "target_field", "function": "uppercase" }
        ]
      }
    end

    let(:invalid_schema) do
      {
        "provider": {
          "name": "MyProvider",
          "baseUrl": "https://provider.example.com",
          "payment_path": "/payments"
        }
      }
    end

    it "adds no errors when a valid schema is provided" do
      record = Integration.new
      record.config = valid_schema
      validator = JsonSchemaValidator.new
      validator.validate(record)

      expect(record.errors).to be_empty
    end

    it "adds errors with details when an invalid schema is provided" do
      record = Integration.new
      record.config = invalid_schema
      validator = JsonSchemaValidator.new
      validator.validate(record)

      expect(record.errors).not_to be_empty
    end
  end
end
