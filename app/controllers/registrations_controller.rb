class RegistrationsController < Devise::RegistrationsController
 authorize_resource :class => false
  before_action :set_hightlight
  def profile

    render layout: "application"
  end

  def edit
    render layout: "application"
  end

  def change_password
    @user = User.find(current_user.id)
    respond_to do |format|
      new_params = params.require(:user).permit(:current_password, :password,
                                                :password_confirmation)
      is_valid = @user.update_with_password(new_params)
      if is_valid
        set_flash_message :notice, :updated
        sign_in @user, :bypass => true
        format.html { redirect_to after_update_path_for(@user) }
        format.js {}

      else
        format.html { render "edit" }
        format.js {}
      end
    end
  end

  def update
    new_params = params.require(:user).permit(:username,
                                              :avatar, :email, :password,
                                              :password_confirmation,
                                              :current_password,
                                              :company, :name, :city, :country, :postal_code, :phone)

    @user = User.find(current_user.id)
    is_valid = @user.update_without_password(new_params)

    if is_valid
      redirect_to profile_path(@user)


    else
      render "edit"
    end

  end

  #end action updates

  def add_avatar
    new_params = params.require(:user).permit(:avatar)
    @user = User.find(current_user.id)
    is_valid = @user.update_without_password(new_params)
    respond_to do |format|
      if is_valid
        set_flash_message :notice, :updated
        sign_in @user, :bypass => true
        format.html { redirect_to profile_path(@user) }
        format.js {}

      else
        format.html { render "edit" }
        format.js {}
      end
    end # end respond_to
  end

  # end action add_avatar

  def new
    render layout: "blank"
    @condo = Condo.all
    super

  end

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    respond_to do |format|
      if resource_saved
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          format.html { respond_with resource, location: after_sign_up_path_for(resource) }
          format.js {}
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          format.html { respond_with resource, location: after_inactive_sign_up_path_for(resource) }
          format.js {}

        end
      else
        clean_up_passwords resource
        format.html { respond_with resource }
        format.js {}
      end

    end
  end
  private
  def set_hightlight
    session[:menustatus] = ''
  end

end

