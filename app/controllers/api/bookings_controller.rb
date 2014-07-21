class Api::BookingsController < ApplicationController
  include ActionController::MimeResponds
  http_basic_authenticate_with name: "admin", password: "rms.innoria"
  skip_before_filter :authenticate_user!

  def index
    
  end

  def make_a_booking
    
  end
end
