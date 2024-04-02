require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:payment) { create(:payment) }

    it 'returns a success response' do
      get :show, params: { id: payment.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:client) { create(:client) }
      let(:integration) { create(:integration, client:) }
      let(:valid_params) do
        { payment: { capture: true, status: 'pending', order_id: 1, payment_type: 'credit',
                     source_type: 'card', client_id: client.id, integration_id: integration.id } }
      end

      it 'creates a new payment' do
        expect do
          post :create, params: valid_params
        end.to change(Payment, :count).by(1)
      end

      it 'returns a created response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { payment: { capture: nil, status: 'invalid', order_id: 1, payment_type: 'credit', source_type: 'card' } } }

      it 'returns an unprocessable entity response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
