class Api::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    user = User.new(user_params)
    if user.save
      render json: {
          status: 'success',
          message: 'You sign up successfuly',
          results: {
              user_id: user.id,
              email: user.email,
              name: user.name,
              auth_token: user.authentication_token,
              condo_id: user.condo.id
          }
      }
      return
    else

      # warden.custom_failedure!

      render json: {
          status: 'failed',
          message: user.errors,
          results: {}
      }
    end
  end

  def profile
    user = User.where(:authentication_token => params[:auth_token]).first
    if user
      render json: {
          status: 'success',
          message: 'Your profile',
          results: {
              image: user.avatar_file_name.nil? == true ? nil : user.avatar.url(:medium),
              email: user.email,
              username: user.username,
              name: user.name,
              company: user.company,
              country: user.country,
              city: user.city,
              postal_code: user.postal_code,
              phone: user.phone ,
              interest: user.interest
          }
      }
    else
      render json: {
          status: 'failed',
          message: 'You can sign in/sign up to do it',
          results: {}
      }, status: 404
    end
  end

  def edit_profile
   
    user = User.where(:authentication_token => params[:auth_token]).first
    if user
      is_valid = false
        if params[:image]
        image = read_image(params[:image])
      is_valid = user.update_without_password(
      interest: params[:interest] , city: params[:city] ,  name: params[:name] , phone: params[:phone] , avatar: image.open

        )else
        is_valid = user.update_without_password(
       interest: params[:interest] ,  city: params[:city] ,  name: params[:name] , phone: params[:phone] )
        end

      if is_valid
        render json: {
            status: 'success',
            message: 'You edit profile successfuly',
            results: {}
        }
      else
        render json: {
            status: 'failed',
            message: user.errors.full_messages,
            results: {}
        }
      end
    else
      render json: {
          status: 'failed',
          message: 'You can sign in/sign up to do it',
          results: {}
      }, status: 404
    end
  end

  def change_password
    user = User.where(:authentication_token => params[:auth_token]).first
    if user
      unless params[:password].blank?
        unless params[:password_confirmation].blank?
          new_params = params.permit(:current_password, :password, :password_confirmation)
          is_valid = user.update_with_password(new_params)
          if is_valid
            render json: {
                status: 'success',
                message: 'You change password successfuly',
                results: {}
            }
          else
            render json: {
                status: 'failed',
                message: user.errors,
                results: {}
            }
          end
        else
          render json: {
            status: 'failed',
            message: {:password_confirmation => ['can not be blank']},
            results: {}
          }
        end
      else
       render json: {
            status: 'failed',
            message: {:password => ['can not be blank']},
            results: {}
       }
      end
    else
      render json: {
          status: 'failed',
          message: 'You can sign in/sign up to do it',
          results: {}
      }
    end
  end

  protected
    def user_params
      params.permit(:name, :email, :phone, :city, :password, :password_confirmation, :condo_id)
    end
    def read_image(image_data)
      @tempfile = Tempfile.new('image')
@tempfile.binmode
@tempfile.write Base64.decode64(image_data[:file_data])
@tempfile.rewind

ActionDispatch::Http::UploadedFile.new(
:tempfile => @tempfile,
:content_type => image_data[:content_type],
:filename => image_data[:filename]
)
    end
end

