class Api::ContactUsController < Api::ApiController
  skip_before_action :authenticate_user_from_token!

  def create
    @send_contact_us = ContactUs.create(contact_us_params)
    if @send_contact_us.valid?
      return render json: PublicFunction.data_json('success', 'Send message success!', 1, @send_contact_us)
    else
      return render json: PublicFunction.data_json('failed', @send_contact_us.errors.messages, 0, nil)
    end
  end

  private
    def contact_us_params
      params.permit(:name, :email, :phone, :message, :role)
    end
end

