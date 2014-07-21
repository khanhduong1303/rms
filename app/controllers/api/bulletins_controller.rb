class Api::BulletinsController < Api::ApiController
  before_action :set_bulletin, only: [:show]
  before_action :set_bulletins, only: [:index]
  respond_to :json

  def index
    unless @bulletins.nil?
      render json: { status: 'success', message: 'Found bulletins', data: @bulletins }
    else
      render json: { status: 'success', message: 'Not found bulletins', data: {} }
    end
  end

  def show
    if !@bulletin.nil?
      render json: { status: 'success', message: 'Found bulletin', data: @bulletin }
    else
      render json: { status: 'failed', message: 'Not found bulletin', data: {} }
    end
  end

  private
    def set_bulletin
      begin
        @bulletin = Bulletin.find(params[:bulletin_id])
      rescue ActiveRecord::RecordNotFound => e
        @bulletin = nil
      end
    end

    def set_bulletins
      @limit = params[:limit].to_i
      @page = params[:page].to_i
      @bulletins = Bulletin.where(send_notify: true).limit(@limit).offset((@page - 1) * @limit).order(date: :desc)
      unless @bulletins.present?
        @bulletins = nil
      end
    end
end

