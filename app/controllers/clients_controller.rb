class ClientsController < ApplicationController
  def show
    render json: Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Client not found' }, status: :not_found
  end

  def index
    render json: Client.all
  end

  def create
    client = ClientService.new.create_new_client
    client.name = client_params[:name]
    if client.save
      render json: client, status: :created
    else
      render json: { errors: client.errors }, status: :unprocessable_entity
    end
  end

  def client_params
    params.require(:client).permit(:name)
  end
end
