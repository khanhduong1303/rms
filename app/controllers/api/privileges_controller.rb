class Api::PrivilegesController < Api::ApiController #ApplicationController
  # skip_before_action :authenticate_user!

  def index
    limit = params[:limit].to_i
    page = params[:page].to_i
    if params[:user_id].nil?
      return render json: PublicFunction.data_json('failed', 'Missing user_id parameter', 0, nil)
    end
    @users = Condo.find(User.find(params[:user_id]).condo_id).users
    arr_group_id  = []
    @users.each do |user|
      arr_group_id << user.id
    end
    if page < 1 or limit < 1
      @results = Privilege.limit(10).where("user_id in (#{arr_group_id.join(',')})")
      @privileges = process_results @results, []
      return render json: PublicFunction.data_json('success', 'Privilege list', @privileges.size, @privileges)
    end

    if limit > 0 and page > 0
      @results = Privilege.limit(limit).offset(page*limit-limit).where("user_id in (#{arr_group_id.join(',')})")
      @privileges = process_results @results, []
      if @privileges.size > 0
        return render json: PublicFunction.data_json('success', 'Privilege list', @privileges.size, @privileges)
      else
        @results = Privilege.limit(10).where("user_id in (#{arr_group_id.join(',')})")
        @privileges = process_results @results, []
        return render json: PublicFunction.data_json('success', 'Privilege list', @privileges.size, @privileges)
      end
    end
  end

  def privilege_detail
    privilege_id = params[:privilege_id]
    if Privilege.where(:id => privilege_id).size > 0
      render json: PublicFunction.data_json('success', 'Show Privilege', 1, process_results(Privilege.where(id:privilege_id), {}) )
    else
      render json: PublicFunction.data_json('failed', 'Privilege not found', 0, nil)
    end
  end

  def redeem_previlege
    if !params[:user_id].nil? and !params[:privilege_id].nil?
      if Privilege.where(:id => params[:privilege_id]).size < 1
        return render json: PublicFunction.data_json('failed', 'Privilege not found', 0, nil)
      end
      if User.where(:id => params[:user_id]).size < 1
        return render json: PublicFunction.data_json('failed', 'User not found', 0, nil)
      end
      if PrivilegeUser.where(user_id: params[:user_id], privilege_id: params[:privilege_id]).size > 0
        return render json: PublicFunction.data_json('failed', 'Can\'t redeem again', 0, nil)
      end
      @redeem = PrivilegeUser.create(:user_id => params[:user_id], :privilege_id => params[:privilege_id])
      return render json: PublicFunction.data_json('success', 'Redeem success', 1, @redeem)
      # render json: {:status=>"Success", :message=>'Joined', :data=>@join_event}
    else
      render json: PublicFunction.data_json('failed', 'Missing parameter', 0, nil)
      # render json: {:status=>"Fail", :message=>'Join fail', :data=>nil}
    end
  end

  def my_privileges
    limit = params[:limit].to_i
    page = params[:page].to_i
    if params[:user_id].nil? || params[:user_id].blank?
      return render json: PublicFunction.data_json('failed', 'Missing user_id parameter', 0, nil)
    end
    begin
      arr_group_id  = []
      PrivilegeUser.where(user_id: params[:user_id]).each do |pri_ur|
        arr_group_id << pri_ur.privilege_id
      end
      @results = Privilege.where("id in (#{arr_group_id.join(',')})")
      @privileges = process_results @results, []
      return render json: PublicFunction.data_json('success', 'My privilege list', @privileges.size, @privileges)
    rescue
      return render json: PublicFunction.data_json('failed', 'Error load my privileges!', 0, nil)
    end

  end

  def process_results results=nil, type=[]
    if type.is_a?(Array)
      privileges_data=type
      i=0
      results.each do |privilege|
        temp = Hash.new
        temp[:id]= privilege.id
        temp[:location]= privilege.location
        temp[:price]= privilege.price
        temp[:distance]= privilege.distance
        temp[:date_expiry]=privilege.date_expiry
        temp[:description]=privilege.description
        temp[:user_id]=privilege.user_id
        temp[:created_at]=privilege.created_at
        temp[:updated_at]=privilege.updated_at
        temp[:name]=privilege.name
        temp[:phone]=privilege.phone
        temp[:date_time_detail]=privilege.date_time_detail
        temp[:image_path]=privilege.image_path.url
        privileges_data[i] = temp
        #temp[b.status] = b.status
        #facilities[i][:ok] = 'ok'
        i+=1
      end
      return privileges_data
    else
      results.each do |privilege|
        temp = Hash.new
        temp[:id]= privilege.id
        temp[:location]= privilege.location
        temp[:price]= privilege.price
        temp[:distance]= privilege.distance
        temp[:date_expiry]=privilege.date_expiry
        temp[:description]=privilege.description
        temp[:user_id]=privilege.user_id
        temp[:created_at]=privilege.created_at
        temp[:updated_at]=privilege.updated_at
        temp[:name]=privilege.name
        temp[:phone]=privilege.phone
        temp[:date_time_detail]=privilege.date_time_detail
        temp[:image_path]=privilege.image_path.url
        return temp
      end
    end

  end
end
