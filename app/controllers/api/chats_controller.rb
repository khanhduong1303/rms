class Api::ChatsController < ApplicationController
  include ActionController::MimeResponds
  skip_before_filter :authenticate_user!
  def request_friend
    if !params[:request_user_id].nil? && !params[:confirm_user_id].nil?
       if User.where(id:params[:request_user_id]).size < 1
         return render json: data_json('failed', 'request_user not found', 0, nil)
         end
       if User.where(id:params[:confirm_user_id]).size < 1
         return render json: data_json('failed', 'confirm_user not found', 0, nil)
       end
       if (FriendList.where(request_user: params[:request_user_id], confirm_user: params[:confirm_user_id]).size > 0 || FriendList.where(request_user: params[:confirm_user_id], confirm_user: params[:request_user_id]).size > 0)
         return render json: data_json('failed', 'Request already exist!', 0, nil)
       end
       @request_friend = FriendList.create(request_user: params[:request_user_id], confirm_user: params[:confirm_user_id], is_confirm:false)
      if @request_friend
        return render json: data_json('success', 'Send request success!', 1, @request_friend)
      else
        return render json: data_json('failed', 'Send request was not success!', 0, nil)
      end
    else
      return render json: data_json('failed', 'Missing parameters', 0, nil)
    end
  end

  def confirm_friend_request
    if !params[:friend_list_id].nil?
      if FriendList.where(id:params[:friend_list_id]).size > 0
        FriendList.find(params[:friend_list_id]).update(is_confirm:true)
        @confirm_friend = FriendList.find(params[:friend_list_id])
        if @confirm_friend
          return render json: data_json('success', 'Confirm request success!', 1, @confirm_friend)
        else
          return render json: data_json('failed', 'Confirm request was not success!', 0, nil)
        end
      else
        return render json: data_json('failed', 'friend_list_id not found', 0, nil)
      end
    else
      return render json: data_json('failed', 'Missing parameters', 0, nil)
    end
  end

  def friend_list
    limit = params[:limit].to_i
    page = params[:page].to_i
    user_id = params[:user_id]
    if user_id.nil? || User.where(id:user_id).size < 1
      return render json: data_json('failed', 'Missing user_id parameter or user_id not found', 0, nil)
    end
    if page < 1 or limit < 1
      @friend_list = FriendList.where("(request_user= #{user_id.to_i} OR confirm_user = #{user_id.to_i}) AND is_confirm = #{true}").limit(10)
      return render json: data_json('success', 'Friend list', @friend_list.size, @friend_list)
    end
    if limit > 0 and page > 0
      @friend_list = FriendList.where("(request_user= #{user_id.to_i} OR confirm_user = #{user_id.to_i}) AND is_confirm = #{true}").limit(limit).offset(page*limit-limit)
      if @friend_list.size > 0
        return render json: data_json('success', 'Friend list', @friend_list.size, @friend_list)
      else
        @friend_list = FriendList.where("(request_user= #{user_id.to_i} OR confirm_user = #{user_id.to_i}) AND is_confirm = #{true}").limit(10)
        return render json: data_json('success', 'Friend list', @friend_list.size, @friend_list)
      end
    end
  end

  def pending_request
    limit = params[:limit].to_i
    page = params[:page].to_i
    user_id = params[:user_id]
    if user_id.nil? || User.where(id:user_id).size < 1
      return render json: data_json('failed', 'Missing user_id parameter or user_id not found', 0, nil)
    end
    if page < 1 or limit < 1
      @friend_list = FriendList.where("confirm_user = #{user_id.to_i} AND is_confirm = #{false}").limit(10)
      return render json: data_json('success', 'Pending list', @friend_list.size, @friend_list)
    end
    if limit > 0 and page > 0
      @friend_list = FriendList.where("confirm_user = #{user_id.to_i} AND is_confirm = #{false}").limit(limit).offset(page*limit-limit)
      if @friend_list.size > 0
        return render json: data_json('success', 'Pending list', @friend_list.size, @friend_list)
      else
        @friend_list = FriendList.where("confirm_user = #{user_id.to_i} AND is_confirm = #{false}").limit(10)
        return render json: data_json('success', 'Pending list', @friend_list.size, @friend_list)
      end
    end
  end

  def neightbours
    limit = params[:limit].to_i
    page = params[:page].to_i
    user_id = params[:user_id]
    if user_id.nil? || User.where(id:user_id).size < 1
      return render json: data_json('failed', 'Missing user_id parameter or user_id not found', 0, nil)
    end
    if page < 1 or limit < 1
      @neightbour_list = User.where(is_status: true, condo_id: User.find(user_id.to_i).condo_id).limit(10)
      return render json: data_json('success', 'Neightbour list', @neightbour_list.size, @neightbour_list)
    end
    if limit > 0 and page > 0
      @neightbour_list = User.where(is_status: true, condo_id: User.find(user_id.to_i).condo_id).limit(limit).offset(page*limit-limit)
      if @neightbour_list.size > 0
        return render json: data_json('success', 'Neightbour list', @neightbour_list.size, @neightbour_list)
      else
        @neightbour_list = User.where(is_status: true, condo_id: User.find(user_id.to_i).condo_id).limit(10)
        return render json: data_json('success', 'Neightbour list', @neightbour_list.size, @neightbour_list)
      end
    end
  end

  private
  def data_json status, message, total, results=nil
    return {:status => status, :message => message, :total => total, :results => results}
  end
end
