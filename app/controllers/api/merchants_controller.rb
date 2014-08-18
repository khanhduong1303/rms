class Api::MerchantsController < Api::ApiController
  skip_before_action :authenticate_user_from_token!

  def create
    @merchant = Merchant.create(merchant_params)
    if @merchant.valid?
      render json: { status: 'success', message: 'Merchant create success', data: {} }, status: :created
    else
      render json: { status: 'failed', message: @merchant.errors.messages, data: {} }, status: :ok
    end
  end

  private
    def merchant_params
      params.permit(:name, :email, :phone)
    end
end
