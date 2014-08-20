class Api::FeedbacksController < Api::ApiController
	 # before_filter :ensure_params_exist , :only => [:create ]
	  skip_before_action :authenticate_user_from_token!
	def create 
    image = feedback_param(params[:image])
    feed = Feedback.new(:feedback_category_id => params[:feedback_category_id], :title => params[:title] , :content => params[:content] , :user_id => params[:user_id] ,
    :image =>   image.open )
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
  def list_cat
     @cat =  User.find(params[:user_id]).condo.feedback_categories.collect {|c| [c.name, c.id]}

         render json: {
        status: "success",
        message: "list feedback category" ,
        result:  @cat 
      }, status: 200 
  end  
    def ensure_params_exist
      return unless params[:feedback].blank?
      render json: {
        status: false,
        message: "feedback params is missing" ,
        result: {}
      }, status: 422 
    end

 def feedback_param(image_data)
@tempfile = Tempfile.new('image')
@tempfile.binmode
@tempfile.write Base64.decode64(image_data[:file_data])
@tempfile.rewind
 
ActionDispatch::Http::UploadedFile.new(
:tempfile => @tempfile,
:content_type => image_data[:content_type],
:filename => image_data[:filename]
)
end
end