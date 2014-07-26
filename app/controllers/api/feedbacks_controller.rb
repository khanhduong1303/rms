class Api::FeedbacksController < Api::ApiController
	 before_filter :ensure_params_exist , :only => [:create ]
	
	def create
    feed = Feedback.new(feedback_params)
    if feed.save
      render json: {
    status: "success",
    message:  "You have sent 1 feedback ",
    result: {
             
            }
      } 
      return
    else
    
      render json: {
    status: "fails",
    message:  feed.errors,
    result:{
             
            }
      } , status: 422
    end
  end
    def ensure_params_exist
      return unless params[:feedback].blank?
      render json: {
        status: false,
        message: "feedback params is missing" ,
        result: {}
      }, status: 422 
    end

  def feedback_params
  	 params[:feedback].permit(:feedback_category_id, :user_id , :title, :content)
  
  end	
end