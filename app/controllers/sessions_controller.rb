class SessionsController < Devise::SessionsController
  layout "blank"
  authorize_resource :class => false 
  def new
    @condo = Condo.all
    super
  end
  # def create
  #   # params[:user].merge!(remember_me: 1)
  #   super
  # end

end
