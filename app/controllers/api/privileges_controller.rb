class Api::PrivilegesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    limit = params[:limit].to_i
    page = params[:page].to_i
    if page < 1 or limit < 1
      @privileges = Privilege.limit(10)
      return render json: data_json('success', 'Privilege list', @privileges.size, @privileges)
    end

    if limit > 0 and page > 0
      @privileges = Privilege.limit(limit).offset(page*limit-limit)
      if @privileges.size > 0
        return render json: data_json('success', 'Privilege list', @privileges.size, @privileges)
      else
        @privileges = Privilege.limit(10)
        return render json: data_json('success', 'Privilege list', @privileges.size, @privileges)
      end
    end
  end

  def privilege_detail
    privilege_id = params[:privilege_id]
    if Privilege.where(:id => privilege_id).size > 0
      render json: data_json('success', 'Show events', 1, Privilege.find(privilege_id))
    else
      render json: data_json('failed', 'Event not found', 0, nil)
    end
  end

  def redeem_previlege
    
  end

  private
  def data_json status, message, total, results=nil
    return {:status => status, :message => message, :total => total, :results => results}
  end
end
