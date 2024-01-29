class ChargesController < ApplicationController
  before_action :set_charge, only: %i[ show ]

  # GET /charges
  def index
    @charges = Charge.all

    render json: @charges
  end

  # GET /charges/1
  def show
    render json: @charge
  end

  # POST /charges
  def create
    @charge = Charge.new(charge_params)

    if @charge.save
      ChargeJob.perform_async(@charge.id)
      render json: @charge, status: :created, location: @charge
    else
      render json: @charge.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_charge
      @charge = Charge.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def charge_params
      params.require(:charge).permit(:capture, :status, :order_id, :payment_type, :source_type)
    end
end
