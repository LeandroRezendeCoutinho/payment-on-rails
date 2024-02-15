# frozen_string_literal: true

class JsonSchemaValidator < ActiveModel::Validator
  SCHEMA = {
    'type' => 'object',
    'required' => %w[provider mapping],
    'properties' => {
      'provider' => {
        'type' => 'object',
        'required' => %w[name baseUrl payment_path auth_path auth_method credentials],
        'properties' => {
          'name' => { 'type' => 'string' },
          'baseUrl' => { 'type' => 'string' },
          'payment_path' => { 'type' => 'string' },
          'auth_path' => { 'type' => 'string' },
          'auth_method' => { 'type' => 'string' },
          'credentials' => { 'type' => 'object' }
        }
      },
      'mapping' => {
        'type' => 'array',
        'minItems' => 1,
        'maps' => {
          'type' => 'object',
          'required' => %w[from to],
          'properties' => {
            'from' => { 'type' => 'string' },
            'to' => { 'type' => 'string' },
            'function' => { 'type' => 'string' }
          }
        }
      }
    }
  }.freeze

  def validate(record)
    errors = JSON::Validator.fully_validate(SCHEMA, record.config.to_json, errors_as_objects: true)
    return if errors.empty?

    record.errors.add(:schema, message: errors)
  end
end
