class Api::BulletinsController < Api::ApiController
  before_action :set_bulletin, only: [:show]
  before_action :set_bulletins, only: [:index]

  def index
    unless @bulletins.nil?
      render json: {status: 'success', message: 'Found bulletins', total: @total, results: @bulletins.to_json(only: [:id])}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found bulletins', results: {}}, status: :not_found
    end
  end

  def show
    if !@bulletin.nil?
      render json: {status: 'success', message: 'Found bulletin', results: @bulletin}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found bulletin', results: {}}, status: :not_found
    end
  end

  private
    def set_bulletin
      begin
        @bulletin = Bulletin.select(:id, :title, :date, :content, :image_path_file_name).find(params[:bulletin_id])
      rescue ActiveRecord::RecordNotFound => e
        @bulletin = nil
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
        @bulletins = condo.bulletins.select(:id, :title, :date ,:content, :image_path_file_name).where(send_notify: true).limit(@limit).offset((@page - 1) * @limit).order(date: :desc)
      rescue Exception => e
        @bulletins = nil
      end
    end
end

