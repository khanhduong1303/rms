class Api::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token
  before_filter :ensure_params_exist, :only => [:change_password, :edit_profile, :create]

  def create
    user = User.new(user_params)
    if user.save
      render json: {
          status: "success",
          message: "You sign up successfuly",
          result: {
              email: user.email,
              authentication_token: user.authentication_token
          }
      }
      return
    else
      warden.custom_failure!
      render json: {
          status: "fails",
          message: user.errors,
          result: {

          }
      }, status: 422
    end
  end

  def profile
    user = User.where(:authentication_token => params[:authentication_token]).first
    if user

      render json: {
          status: "success",
          message: "Your profile",
          result: {
              image: user.avatar.url(:big),
              email: user.email,
              username: user.username,
              name: user.name,
              company: user.company,
              country: user.country,
              city: user.city,
              postal_code: user.postal_code,
              phone: user.phone


          }
      }

    else
      render json: {
          status: "fail",
          message: "You can sign in/sign up to do it",
          result: {

          }
      }, status: 404
    end
  end

  def edit_profile
    new_params = params.require(:user).permit(:username,
                                              :avatar, :email, :password,
                                              :password_confirmation,
                                              :current_password,
                                              :company, :name, :city, :country, :postal_code, :phone)

    user = User.where(:authentication_token => params[:authentication_token]).first
    if user
      is_valid = user.update_without_password(new_params)

      if is_valid
        render json: {
            status: "success",
            message: "You edit profile successfuly",
            result: {

            }
        }
      else
        render json: {
            status: "fail",
            message: user.errors.full_messages,
            result: {

            }
        }
      end
    else
      render json: {
          status: "fail",
          message: "You can sign in/sign up to do it",
          result: {

          }
      }, status: 404
    end
  end

  def change_password
    user = User.where(:authentication_token => params[:authentication_token]).first
    if user
      new_params = params.require(:user).permit(:current_password, :password,
                                                :password_confirmation)
      is_valid = user.update_with_password(new_params)
      if is_valid
        render json: {
            status: "success",
            message: "You change password successfuly",
            result: {

            }
        }
      else

        render json: {
            status: "fail",
            message: user.errors.full_messages,
            result: {

            }
        }

      end
    else
      render json: {
          status: "fail",
          message: "You can sign in/sign up to do it",
          result: {

          }
      }, status: 404
    end
  end

  protected

  def ensure_params_exist
    return unless params[:user].blank?
    render json: {
        status: false,
        message: "user params is missing",
        result: {}
    }, status: 422
  end


  def user_params
    params[:user].permit(:username, :email, :phone, :condo_id, :postal_code, :enquiry, :password, :password_confirmation)
  end
end