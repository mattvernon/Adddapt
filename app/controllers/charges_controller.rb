class ChargesController < ApplicationController
  before_action :set_charge, only: [:show, :edit, :update, :destroy]

  def index
    @charges = Charge.all
  end

  def show
  end

  def new
    @charge = Charge.new
    @customer = Customer.find(params[:customer])
  end

  def process_payment
    @charge = Charge.new
    @customer = Customer.find(params[:customer_id])

    Stripe::Charge.create({
      :amount => @customer.amount * 100,
      :currency => 'usd',
      :application_fee => (@customer.amount * 100) / 5,
      :customer => @customer.stripe_customer_id,
      :destination => @customer.designer_uid
    })

    respond_to do |format|
      if @charge.save
        format.html { redirect_to @charge, notice: 'Charge was successfully created.' }
        format.json { render :show, status: :created, location: @charge }
      else
        format.html { render :new }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_charge
      @charge = Charge.find(params[:id])
    end

    def charge_params
      params.require(:charge).permit(:amount, :designer_uid, :customer_token, :customer_id, :designer_id)
    end
end
