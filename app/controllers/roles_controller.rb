class RolesController < ApplicationController
	# authorize_resource :user , :parent => false
    authorize_resource 
    respond_to :js , :json , :html
	def index
		@roles = current_user.condo.roles.where('role_name != "Admin" ')
	end	
	def show
    @role = Role.find(params[:id])
    @permission = @role.permissions
    end
    def new
    @per_role = PerRole.new
    
    @permission =   Permission.all
    
    end    
    def create
            name = params[:per_role][:role_id] 
          @check =  Role.where('role_name = (?) and condo_id = (?)' , name , current_user.condo_id).size
            if @check == 0
            @role = Role.new
            @role.role_name = name
            @role.condo_id = current_user.condo_id
            @flag = false
    if @role.save
        if params[:per_role][:permission_id]
            per = params[:per_role][:permission_id]
            per.each do |p|
                        if p != "" && !p.nil?
                            @p = PerRole.new
                            @p.role_id =  @role.id
                            @p.permission_id = p
                            @p.save
                        end #end thrid if 
                    end 
        end#end second if 
        @flag = true
        @permission = @role.permissions  
        @roles = current_user.condo.roles.where('role_name != "Admin" ')
    else
        
    
    end#end first if 
    else
    @per_role = PerRole.new
    @permission =   Permission.all
    end 
    end#end def create

    def add_permission
    @per = PerRole.new
    @role = Role.find(params[:id])
    @allper = 	Permission.all
    @role_per = @role.permissions
    @permission = @allper - @role_per
    end
    def process_add_permission
        role = params[:per_role][:role_id] 
    if params[:per_role][:permission_id] && role
        per = params[:per_role][:permission_id]
         per.each do |p|
            if p != "" && !p.nil?
         @p = PerRole.new
         @p.role_id = role
          @p.permission_id = p
         @p.save
            end
                  end
   
 	
    end
       @role = Role.find(role)
       @permission = @role.permissions
    end 
    def confirm_remove
        rid = params[:rid]
        pid = params[:pid]
       @pr = PerRole.where(:role_id => rid , :permission_id => pid).first
        
    end
    def remove_permission

        @pr = PerRole.find(params[:id])
        @role = Role.find( @pr.role_id)
        @pr.destroy()
        @permission = @role.permissions
        
    end

     def destroy
      

     end
     def rename_role
     role = params[:role_id]
     name = params[:name]
     @role = Role.find(role)
     if name  != ""
     @role.role_name = name 
     @role.save
     end 
     @permission = @role.permissions  
     @roles = current_user.condo.roles.where('role_name != "Admin" ')
     end
     def remove_multiple
            role = params[:role_id]
           
    if params[:permission_id] 
        per = params[:permission_id]
         per.each do |p|
            if p != "" && !p.nil?
        @pr = PerRole.where(:role_id => role , :permission_id => p).first      
         @pr.destroy
            end
                 end
    end
       @role = Role.find(role)
       @permission = @role.permissions
     end
     def confirm_drop
      @role = Role.find(params[:id])
     end 
     def drop_role
      @role = Role.find(params[:id])
      @role.destroy
      @roles =current_user.condo.roles.where('role_name != "Admin" ')
     end 

    def perrole_params
      params.require(:per_role).permit(:role_id, {permission_id: [] })
    end
end
