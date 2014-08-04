class AdminsController < ApplicationController
	authorize_resource :user , :parent => false
	# authorize_resource :class => false  
respond_to :js ,:html, :json
def index
	if current_user.condo_id.nil?
		@alluser = User.where('id != (?) ',current_user.id)
		@admin = Role.where('role_name = (?)', 'SuperAdmin').first.users
		@user = @alluser - @admin	
	else	
		@alluser = current_user.condo.users.where('id != (?) ',current_user.id)
	    @admin = current_user.condo.roles.where('role_name = (?)', 'Admin').first.users
		@users = @alluser - @admin
    end
end
def new
	@user = User.new
end	
def create_user
   @user = User.new(user_params)
   @user.save
   	@alluser = current_user.condo.users.where('id != (?) ',current_user.id)
	@admin = current_user.condo.roles.where('role_name = (?)', 'Admin').first.users
	@users = @alluser - @admin

end 	
def manage
	@user = User.find(params[:id])
	@user_role = UserRole.new
	@allrole = current_user.condo.roles
	@userrole = @user.roles
	@role = @allrole - @userrole
end	
def confirm
	@user = User.find(params[:id])
	
end
def process_add_role
  uid = params[:user_role][:user_id] 
    if params[:user_role][:role_id] && uid
        role = params[:user_role][:role_id]
         role.each do |r|
            if r != "" && !r.nil?
         @ur = UserRole.new
         @ur.role_id = r
          @ur.user_id  = uid
         @ur.save
            end
                  end
   
 	
    end
     @user = User.find(uid)
	@user_role = UserRole.new
	@allrole = current_user.condo.roles
	@userrole = @user.roles
	@role = @allrole - @userrole
end	
def remove_role
	uid = params[:uid]
	rid = params[:rid]

	   @ur = UserRole.where(:role_id => rid , :user_id => uid).first      
        @ur.destroy
              @user = User.find(uid)
	@user_role = UserRole.new
	@allrole = current_user.condo.roles
	@userrole = @user.roles
	@role = @allrole - @userrole
end

def change_active
	
	begin
      @user = User.find(params[:id])
	  @user.active = params[:active]
	  @user.save
	  if @user.active
      render json: {status: 'active'}
      else
      render json: {status: 'block'}	
      end
    rescue Exception => e
      render json: {status: 'failed'}
    end
end
def destroy
	@u = User.find(params[:id])
	@u.destroy()
	@alluser = current_user.condo.users.where('id != (?) ',current_user.id)
	@admin = current_user.condo.roles.where('role_name = (?)', 'Admin').first.users
	@users = @alluser - @admin

end	
def destroy_multiple

           
    if params[:user_id] 
        user = params[:user_id]
         user.each do |u|
            if u != "" && !u.nil?
        @user = User.find(u)      
         @user.destroy
            end
                 end
    end
  	@alluser = current_user.condo.users.where('id != (?) ',current_user.id)
	@admin = current_user.condo.roles.where('role_name = (?)', 'Admin').first.users
	@users = @alluser - @admin
end
 def user_params
    params[:user].permit(:username, :email, :phone, :condo_id, :postal_code, :enquiry, :password, :password_confirmation)
 end
 
end
