class Api::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token

  def create
    user = User.new(user_params)
    if user.save
      render json: {
          status: 'success',
          message: 'You sign up successfuly',
          data: {
              user_id: user.id,
              email: user.email,
              name: user.name,
              token: user.authentication_token,
              condo_id: user.condo.id
          }
      }
      return
    else
      warden.custom_failedure!
      render json: {
          status: 'failed',
          message: user.errors,
          data: {}
      }
    end
  end

  def profile
    user = User.where(:authentication_token => params[:token]).first
    if user
      render json: {
          status: 'success',
          message: 'Your profile',
          data: {
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
          status: 'failed',
          message: 'You can sign in/sign up to do it',
          data: {}
      }, status: 404
    end
  end

  def edit_profile
    new_params = params.permit(:username, :avatar, :email, :password, :password_confirmation, :current_password, :company, :name, :city, :country, :postal_code, :phone)

    user = User.where(:authentication_token => params[:token]).first
    if user
      is_valid = user.update_without_password(new_params)

      if is_valid
        render json: {
            status: 'success',
            message: 'You edit profile successfuly',
            data: {}
        }
      else
        render json: {
            status: 'failed',
            message: user.errors.full_messages,
            data: {}
        }
      end
    else
      render json: {
          status: 'failed',
          message: 'You can sign in/sign up to do it',
          data: {}
      }, status: 404
    end
  end

  def change_password
    user = User.where(:authentication_token => params[:token]).first
    if user
      if params[:password]
        if params[:password_confirmation]
          new_params = params.permit(:current_password, :password, :password_confirmation)
          is_valid = user.update_with_password(new_params)
          if is_valid
            render json: {
                status: 'success',
                message: 'You change password successfuly',
                data: {}
            }
          else
            render json: {
                status: 'failed',
                message: user.errors.full_messages,
                data: {}
            }
          end
        else
          render json: {
            status: 'failed',
            message:  'Password confirmation can not be blank',
            data: {}
          }
        end
      else
       render json: {
            status: 'failed',
            message:  'Password can not be blank',
            data: {}
       }
      end
    else
      render json: {
          status: 'failed',
          message: 'You can sign in/sign up to do it',
          data: {}
      }, status: 404
    end
  end

  protected
    def user_params
      params.permit(:name, :email, :phone, :city, :password, :password_confirmation, :condo_id)
    end
end

