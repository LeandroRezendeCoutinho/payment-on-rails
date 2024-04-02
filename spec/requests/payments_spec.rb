require 'rails_helper'

RSpec.describe "/payments", type: :request do # rubocop:disable Metrics/BlockLength
  let(:client) { create(:client) }
  let(:integration) { create(:integration, client:) }
  let(:valid_attributes) do
    {
      amount_cents: 100,
      amount_currency: 'BRL',
      capture: true,
      status: 'pending',
      order_id: '1',
      payment_type: 'credit',
      source_type: 'card',
      client_id: client.id,
      integration_id: integration.id
    }
  end

  let(:invalid_attributes) do
    {
      amount_cents: nil,
      amount_currency: nil
    }
  end

  let(:valid_headers) do
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      create(:payment, client:, integration:)
      get payments_url, headers: valid_headers, as: :json

      attributes = JSON.parse(response.body).first.symbolize_keys.except(:id, :created_at, :updated_at)

      expect(response).to be_successful
      expect(JSON.parse(response.body)).to be_instance_of(Array)
      expect(attributes).to include(valid_attributes)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      payment = Payment.create! valid_attributes
      get payment_url(payment), as: :json

      attributes = JSON.parse(response.body).symbolize_keys.except(:id)

      expect(response).to be_successful
      expect(attributes).to include(valid_attributes)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Payment" do
        expect do
          post payments_url,
               params: { payment: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Payment, :count).by(1)
      end

      it "renders a JSON response with the new payment" do
        post payments_url,
             params: { payment: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Payment" do
        expect do
          post payments_url,
               params: { payment: invalid_attributes }, as: :json
        end.to change(Payment, :count).by(0)
      end

      it "renders a JSON response with errors for the new payment" do
        post payments_url,
             params: { payment: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        skip("Add a hash of attributes valid for your model")
      end

      it "updates the requested payment" do
        payment = Payment.create! valid_attributes
        patch payment_url(payment),
              params: { payment: new_attributes }, headers: valid_headers, as: :json
        payment.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the payment" do
        payment = Payment.create! valid_attributes
        patch payment_url(payment),
              params: { payment: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
