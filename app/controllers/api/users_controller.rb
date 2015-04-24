class Api::UsersController < Api::ApiController

  def get_users
    if !params[:condo_id].nil?
      users = Condo.find(params[:condo_id]).users.where.not(:username => 'guest').order(created_at: :desc)
      users = process_results users
      return render json: PublicFunction.data_json('success', 'List facility', users.size, users)
    else
      return render json: PublicFunction.data_json('failed', 'Missing condo_id parameter', 0, nil)
    end
  end


  private
  def process_results results=nil
    user_data=[]
    i=0
    results.each do |user|
      temp = Hash.new
      temp[:id]= user.id
      temp[:name]= user.name
      temp[:username]= user.username
      temp[:email]=user.email
      temp[:city]=user.city
      temp[:country]=user.country
      temp[:created_at]=user.created_at
      temp[:updated_at]=user.updated_at
      temp[:phone]=user.phone
      temp[:company]=user.company
      temp[:postal_code]=user.postal_code
      temp[:enquiry]=user.enquiry
      temp[:avatar]= user.avatar_file_name.nil? == true ? nil : user.avatar.url(:small)
      user_data[i] = temp
      i+=1
    end
    return user_data
  end
end

