require 'rails_helper'

RSpec.describe IntegrationsController, type: :controller do # rubocop:disable Metrics/BlockLength
  describe 'GET #index' do
    let!(:integration1) { create(:integration) }
    let!(:integration2) { create(:integration) }
    let(:config) do
      {
        "provider" => {
          "name" => "Provider Name",
          "baseUrl" => "http://localhost:3000",
          "payment_path" => "/payments",
          "auth_path" => "",
          "auth_method" => "post",
          "credentials" => { "user" => "user", "password" => "password" }
        },
        "mapping" => [
          { "from" => "from", "to" => "to", "function" => "function" }
        ]
      }
    end

    before { get :index }

    it 'returns a JSON response' do
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'includes all Integration objects in the JSON response' do
      expect(JSON.parse(response.body)).to match_array([
                                                         a_hash_including('id' => integration1.id),
                                                         a_hash_including('id' => integration2.id)
                                                       ])
    end

    it 'does not include any additional objects in the JSON response' do
      expect(JSON.parse(response.body).length).to eq(2)
    end

    it 'includes the correct attributes for each Integration object' do
      expect(JSON.parse(response.body)[0]).to include('name' => integration1.name, 'config' => config)
      expect(JSON.parse(response.body)[1]).to include('name' => integration2.name, 'config' => config)
    end

    it 'sets the @integrations instance variable' do
      expect(assigns(:integrations)).to eq([integration1, integration2])
    end
  end

  describe "#show" do
    let(:integration) { create(:integration) }

    before do
      allow(Integration).to receive(:find).and_return(integration)
    end

    it "renders the integration as JSON" do
      get :show, params: { id: integration.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(JSON.parse(response.body)).to eq(JSON.parse(integration.to_json))
    end

    it "returns a 404 error if the integration does not exist" do
      allow(Integration).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
      get :show, params: { id: integration.id }
      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(JSON.parse(response.body)).to eq("error" => "Integration not found")
    end
  end

  describe "POST #create" do
    let(:client) { create(:client) }
    context "with valid parameters" do
      it "creates a new integration" do
        expect do
          post :create, params: { integration: attributes_for(:integration, client_id: client.id) }
        end.to change(Integration, :count).by(1)
      end

      it "renders a JSON response with the new integration" do
        post :create, params: { integration: attributes_for(:integration, client_id: client.id) }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        { name: "client name" }
      end
      it "does not create a new integration" do
        expect do
          post :create, params: { integration: invalid_attributes }
        end.to change(Integration, :count).by(0)
      end

      it "renders a JSON response with errors for the new integration" do
        post :create, params: { integration: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match("application/json; charset=utf-8")
      end
    end
  end

  describe '#update' do
    let(:integration) { create(:integration) }
    let(:new_config) do
      {
        "name" => "New Integration Name",
        "config" => {
          "provider" => {
            "name" => "New Provider Name",
            "baseUrl" => "http://localhost:8000",
            "payment_path" => "/charge",
            "auth_path" => "",
            "auth_method" => "post",
            "credentials" => { "user" => "user", "password" => "password" }
          },
          "mapping" => [
            { "from" => "from", "to" => "to", "function" => "function" }
          ]
        }
      }
    end

    it 'updates an integration successfully' do
      put :update, params: { id: integration.id, integration: new_config }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include(new_config)
    end
  end

  describe '#destroy' do
    let!(:integration) { create(:integration) }
    it 'destroys an integration successfully' do
      expect do
        delete :destroy, params: { id: integration.id }
      end.to change(Integration, :count).by(-1)
    end
  end
end
