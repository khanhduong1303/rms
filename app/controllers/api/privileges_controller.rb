class Api::PrivilegesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    limit = params[:limit].to_i
    page = params[:page].to_i
    if page < 1 or limit < 1
      @privileges = Privilege.limit(10)
      return render json: PublicFunction.data_json('success', 'Privilege list', @privileges.size, @privileges)
    end

    if limit > 0 and page > 0
      @privileges = Privilege.limit(limit).offset(page*limit-limit)
      if @privileges.size > 0
        return render json: PublicFunction.data_json('success', 'Privilege list', @privileges.size, @privileges)
      else
        @privileges = Privilege.limit(10)
        return render json: PublicFunction.data_json('success', 'Privilege list', @privileges.size, @privileges)
      end
    end
  end

  def privilege_detail
    privilege_id = params[:privilege_id]
    if Privilege.where(:id => privilege_id).size > 0
      render json: PublicFunction.data_json('success', 'Show Privilege', 1, Privilege.find(privilege_id))
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
      @redeem = PrivilegeUser.create(:user_id => params[:user_id], :privilege_id => params[:privilege_id])
      return render json: PublicFunction.data_json('success', 'Redeem success', 1, @redeem)
      # render json: {:status=>"Success", :message=>'Joined', :data=>@join_event}
    else
      render json: PublicFunction.data_json('failed', 'Missing parameter', 0, nil)
      # render json: {:status=>"Fail", :message=>'Join fail', :data=>nil}
    end
  end
end
