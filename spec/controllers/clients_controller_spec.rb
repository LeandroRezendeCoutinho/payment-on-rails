require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  describe 'GET #show' do
    let(:client) { create(:client) }

    it 'returns client information for valid client ID' do
      get :show, params: { id: client.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq(client.name)
    end

    it 'returns error message for invalid client ID' do
      get :show, params: { id: 'invalid_id' }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Client not found')
    end

    it 'returns error message for empty client ID' do
      get :show, params: { id: '' }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Client not found')
    end
  end

  describe "GET #index" do
    it "renders all clients as json" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'POST #create' do
    it 'creates a new client successfully' do
      post :create, params: { client: { name: 'Test Client' } }
      expect(response).to have_http_status(:success)
      expect(Client.last.name).to eq('Test Client')
    end

    it 'renders error JSON response when client fails to save' do
      post :create, params: { client: { name: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
