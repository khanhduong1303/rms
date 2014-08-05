class Api::ContactUsController < ApplicationController
  include ActionController::MimeResponds
  # http_basic_authenticate_with name: "admin", password: "rms.innoria"
  skip_before_filter :authenticate_user!

  def send_contact_us
    if !params[:name].nil? && !params[:email].nil? && !params[:phone].nil? && !params[:message].nil? && !params[:role].nil?
      @send_contact_us = ContactUs.create(name:params[:name], email:params[:email], phone:params[:phone], message:params[:message], role:params[:role])
      return render json: PublicFunction.data_json('success', 'Send message success!', 1, @send_contact_us)
    else
      return render json: PublicFunction.data_json('failed', 'Missing parameters!',0,nil)
    end
  end

end
