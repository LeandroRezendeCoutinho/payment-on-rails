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
require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:client_id) }
    it { should validate_presence_of(:public_key) }
    it { should validate_presence_of(:private_key) }

    it 'validates format' do
      client = Client.new
      client.name = 'Client Name'
      client.client_id = '17663c88-11e5-45c4-86be-4f56f47c694a'
      client.public_key = '7972cdfb-e088-499d-a3d7-ba37512697ed'
      client.private_key = '0f5efa78-4997-43e4-a5fe-e13f03c529b9'
      expect(client.valid?).to be(true)
    end

    describe 'when client_idf ormat is invalid' do
      it 'returns false' do
        client = Client.new
        client.client_id = 'any string'
        client.public_key = '7972cdfb-e088-499d-a3d7-ba37512697ed'
        client.private_key = '0f5efa78-4997-43e4-a5fe-e13f03c529b'
        expect(client.valid?).to be(false)
      end
    end

    describe 'when public_key format is invalid' do
      it 'returns false' do
        client = Client.new
        client.client_id = '17663c88-11e5-45c4-86be-4f56f47c694a'
        client.public_key = 'any string'
        client.private_key = '0f5efa78-4997-43e4-a5fe-e13f03c529b9'
        expect(client.valid?).to be(false)
      end
    end

    describe 'when private_key format is invalid' do
      it 'returns false' do
        client = Client.new
        client.client_id = '17663c88-11e5-45c4-86be-4f56f47c694a'
        client.public_key = '7972cdfb-e088-499d-a3d7-ba37512697ed'
        client.private_key = 'any string'
        expect(client.valid?).to be(false)
      end
    end
  end
end
