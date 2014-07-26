class FeedbacksController < ApplicationController
	  before_action :set_hightlight
	  respond_to :html, :json , :js
	def index
		@feedbacks = current_user.condo.feedbacks.where(:archive=> false).paginate(:page => params[:page],  :per_page => 5)	
	end
	def index_archive
		@feedbacks = current_user.condo.feedbacks.where(:archive=> true).paginate(:page => params[:page],:per_page => 5)	
	end

	def destroy
	   @feedback = Feedback.find(params[:id])
       @feedback.destroy
       @feedbacks = current_user.condo.feedbacks.where(:archive=> false).paginate(:page => params[:page],:per_page => 5)	
	end
	def destroy_multiple
		if params[:ids]
		@feeds = Feedback.find(params[:ids])

	 @feeds.each do |f|
	 	f.destroy
	 end
	  render json: { status: true }
	 else

	 	render json: { status: false }
	 end
	 

	
	end
	def move_multiple
		if params[:ids]
		@feeds = Feedback.find(params[:ids])

	 @feeds.each do |f|
	 	if f.archive
	 	f.archive = false
	 	f.save
	    else
	    f.archive = true
	 	f.save	
	    end	
	 end
	  render json: { status: true }
	 else

	 	render json: { status: false }
	 end
	 	
	end
	def update_reply
		@reply= FeedbackReply.find(params[:feedback_reply][:id])
		@reply.update(reply_params)
	end
	def create_reply
		 @feedback = Feedback.find(params[:id])
		 @reply= @feedback.feedback_reply
		 if @reply

		 else	
		 @reply = FeedbackReply.new
		end
	end
	def reply
		@reply = FeedbackReply.create(reply_params)
	end	

	def move_archive
		
	end
	def confirm_delete
      @feedback = Feedback.find(params[:id])


	end	
	def show_archive
    end


    def reply_params
      params.require(:feedback_reply).permit(:content, :feedback_id)
    end
    def set_hightlight
      session[:menustatus] = 'feedbacks'
    end
end
