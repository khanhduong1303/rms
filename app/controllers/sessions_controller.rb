class SessionsController < Devise::SessionsController
  layout "blank"

  def new
    @condo = Condo.all
    super

  end
end
