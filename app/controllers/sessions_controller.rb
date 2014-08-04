class SessionsController < Devise::SessionsController
  layout "blank"
  authorize_resource :class => false 
  def new
    @condo = Condo.all
    super

  end
end
