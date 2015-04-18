class PrivilegesController < ApplicationController
  before_action :set_privilege, only: [:show, :edit, :update, :destroy]
  include ActionController::MimeResponds
  before_action :set_hightlight
  authorize_resource
  def index
    set_privileges
    @privilege = Privilege.new
  end

  def show
  end

  def new
    @privilege = Privilege.new
  end

  def edit
  end

  def create
    @privilege = Privilege.new(privilege_params)
      if @privilege.save
        @result=1
        @message=t('common.successfully_created')
      else
        @result=0
        @message= t('common.unsuccess')
      end
    set_privileges
    @privilege = Privilege.new
  end

  def update
      if @privilege.update(privilege_params)
        @result=1
        @message=t('common.successfully_updated')
      else
        @result=0
        @message= t('common.unsuccess')
      end
      set_privileges
      @privilege = Privilege.new
  end

  def destroy
    if @privilege.destroy
      @result=1
      @message=t('common.successfully_destroyed')
    else
      @result=0
      @message= t('common.unsuccess')
    end
    set_privileges
    @privilege = Privilege.new
  end

  private
  def set_privilege
    @privilege = Privilege.find(params[:id])
  end

  def privilege_params
    params.require(:privilege).permit(:location, :price, :name, :distance, :date_expiry, :phone, :date_time_detail, :description, :user_id, :image_path)
  end

  def set_privileges
    if current_user.roles.where(role_name: 'Admin').size > 0
      @privileges = Privilege.all.order('id DESC')
    else
      @privileges = Privilege.where(:user_id => current_user.id)
    end
  end

  def set_hightlight
    session[:menustatus]='privileges'
  end

end
