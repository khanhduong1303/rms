class Api::BulletinsController < Api::ApiController
  before_action :set_bulletin, only: [:show]

  def index
    unless params[:condo_id]
      render json: {status: 'failed', message: 'missing params condo id ', results: {}}, status: :not_found
    end
    begin
        @limit = params[:limit]
        @page = params[:page]
        token = params[:auth_token]
        @limit = @limit.nil? ? 5 : @limit.to_i
        @page = @page.nil? ? 1 : @page.to_i
        condo = Condo.find(params[:condo_id])
        @total = condo.bulletins.all.count
        @bulletins = condo.bulletins.select(:id, :title, :date ,:content).where(send_notify: true).limit(@limit).offset((@page - 1) * @limit).order(date: :desc)
    rescue Exception => e
        @bulletins = nil
    end
    unless @bulletins.nil?
      render json: {status: 'success', message: 'Found bulletins', total: @total, results: @bulletins}, status: :ok
    else
      render json: {status: 'failed', message: 'Not bulletins available', results: {}}, status: :not_found
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
        @bulletin = Bulletin.select(:id, :title, :date, :content).find(params[:bulletin_id])
      rescue ActiveRecord::RecordNotFound => e
        @bulletin = nil
      end
    end


end

