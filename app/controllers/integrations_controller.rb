class IntegrationsController < ApplicationController
  before_action :set_integration, only: %i[show update destroy]

  # GET /integrations
  def index
    @integrations = Integration.all

    render json: @integrations
  end

  # GET /integrations/1
  def show
    render json: @integration
  end

  # POST /integrations
  def create
    @integration = Integration.new(integration_params)

    if @integration.save
      render json: @integration, status: :created, location: @integration
    else
      render json: @integration.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /integrations/1
  def update
    if @integration.update(integration_params)
      render json: @integration
    else
      render json: @integration.errors, status: :unprocessable_entity
    end
  end

  # DELETE /integrations/1
  def destroy
    @integration.destroy!
  end

  private

  def set_integration
    @integration = Integration.find(params[:id])
  end

  def integration_params
    params.require(:integration).permit(
      :name,
      config: [
        provider: [
          :name, :baseUrl, :payment_path, :auth_path, :auth_method, credentials: [:user, :password] # rubocop:disable Style/HashAsLastArrayItem
        ],
        mapping: %i[from to function]
      ]
    )
  end
end
