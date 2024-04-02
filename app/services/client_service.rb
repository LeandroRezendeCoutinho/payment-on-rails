class ClientService
  def create_new_client
    @client = Client.new
    @client.client_id = SecureRandom.uuid
    @client.public_key = SecureRandom.uuid
    @client.private_key = SecureRandom.uuid
    @client
  end
end
