class Api::BulletinsController < Api::ApiController
  before_action :set_bulletin, only: [:show]

  def index
    unless params[:condo_id]
      render json: {status: 'failed', message: 'missing params condo id ', results: {}}, status: :not_found
      return
    end
    begin
        @limit = params[:limit]
        @page = params[:page]
        token = params[:auth_token]
        @limit = @limit.nil? ? 5 : @limit.to_i
        @page = @page.nil? ? 1 : @page.to_i
        condo = Condo.find(params[:condo_id])
        @total = condo.bulletins.all.count
        @bulletins = condo.bulletins.where(send_notify: true).limit(@limit).offset((@page - 1) * @limit).order(date: :desc)
        results = []
    rescue Exception => e
        @bulletins = nil
    end
    unless @bulletins.nil?
      @bulletins.each do |b|
        results << {id: b.id , title: b.title ,date: b.date ,content: b.content ,image_path_thump: b.image_path.url(:thumb)  }
       end 
      render json: {status: 'success', message: 'Found bulletins', total: @total, results: results}, status: :ok
    else
      render json: {status: 'failed', message: 'Not bulletins available', results: {}}, status: :not_found
    end
  end

  def show
    if !@result.nil?
      render json: {status: 'success', message: 'Found bulletin', results:  @result}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found bulletin', results: {}}, status: :not_found
    end
  end

  private
    def set_bulletin
      begin
        b = Bulletin.find(params[:bulletin_id])
        if b.nil?
        @result = nil
        else
        @result = {id: b.id , title: b.title ,date: b.date ,content: b.content ,image_path_thump: b.image_path.url(:thumb) , image_path:  b.image_path.url }
        end
      rescue ActiveRecord::RecordNotFound => e
        @result = nil
      end
    end

    def set_bulletins
      begin
        @limit = params[:limit]
        @page = params[:page]
        token = params[:auth_token]
        @limit = @limit.nil? ? 5 : @limit.to_i
        @page = @page.nil? ? 1 : @page.to_i
        condo = User.find_by_authentication_token(token).condo
        @total = condo.bulletins.all.count
        @bulletins = condo.bulletins.select(:id, :title, :date ,:content).where(send_notify: true).limit(@limit).offset((@page - 1) * @limit).order(date: :desc)
      rescue Exception => e
        @bulletins = nil
      end
    end
end

