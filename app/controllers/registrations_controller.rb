class RegistrationsController < Devise::RegistrationsController
	 layout "blank"


def profile
	render layout: "application"
 @user = current_user


end
def new 

@condo = Condo.all
super

end

def create
	@condo = Condo.all
	super
	
end

end
