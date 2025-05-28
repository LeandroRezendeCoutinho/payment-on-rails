require 'rails_helper'

RSpec.describe Clients::Create do
  describe "create_new_client" do
    it "returns a new created client" do
      client = Clients::Create.call
      client.name = "MyString"

      expect(client.client_id).to be_a(String)
      expect(client.public_key).to be_a(String)
      expect(client.private_key).to be_a(String)
      expect do
        client.save
      end.to change(Client, :count).by(1)
    end
  end
end
