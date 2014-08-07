class Api::BulletinsController < Api::ApiController
  before_action :set_bulletin, only: [:show]
  before_action :set_bulletins, only: [:index]
  skip_before_action :authenticate_user_from_token!

  def index
    unless @bulletins.nil?
      render json: {status: 'success', message: 'Found bulletins', total: @bulletins.count, data: @bulletins}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found bulletins', data: {}}, status: :not_found
    end
  end

  def show
    if !@bulletin.nil?
      render json: {status: 'success', message: 'Found bulletin', data: @bulletin}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found bulletin', data: {}}, status: :not_found
    end
  end

  private
    def set_bulletin
      begin
        @bulletin = Bulletin.select(:id, :title, :date, :content).find(params[:bulletin_id])
      rescue ActiveRecord::RecordNotFound => e
        @bulletin = nil
      end
    end

    def set_bulletins
      begin
        @limit = params[:limit]
        @page = params[:page]
        @limit = @limit.nil? ? 5 : @limit.to_i
        @page = @page.nil? ? 1 : @page.to_i
        @bulletins = Bulletin.select(:id, :title, :date).where(send_notify: true).limit(@limit).offset((@page - 1) * @limit).order(date: :desc)
      rescue Exception => e
        @bulletins = nil
      end
    end
end

