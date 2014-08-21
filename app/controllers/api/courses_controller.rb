class Api::CoursesController < Api::ApiController
  def index
    limit = params[:limit].to_i
    page = params[:page].to_i
    if params[:condo_id].nil?
      return render json: PublicFunction.data_json('failed', 'Missing user_id parameter', 0, {})
    end
    if page < 1 or limit < 1
      @results = Course.limit(10).where(condo_id:params[:condo_id])
      @courses = process_results @results, []
      return render json: PublicFunction.data_json('success', 'Courses list', @courses.size, @courses)
    end

    if limit > 0 and page > 0
      @results = Courses.limit(limit).offset(page*limit-limit).where(condo_id:params[:condo_id])
      @courses = process_results @results, []
      if @courses.size > 0
        return render json: PublicFunction.data_json('success', 'Courses list', @courses.size, @courses)
      else
        @results = Courses.limit(10).where(condo_id:params[:condo_id])
        @courses = process_results @results, []
        return render json: PublicFunction.data_json('success', 'Courses list', @courses.size, @courses)
      end
    end
  end

  def show
    course_id  = params[:course_id ]
    if Course.where(:id => course_id ).size > 0
      render json: PublicFunction.data_json('success', 'Show Course', 1, process_results(Course.where(id:course_id ), {}) )
    else
      render json: PublicFunction.data_json('failed', 'Course not found', 0, {})
    end
  end


  private
  def process_results results=nil, type=[]
    if type.is_a?(Array)
      courses_data=type
      i=0
      results.each do |course|
        temp = Hash.new
        temp[:id]= course.id
        temp[:name]=course.name
        temp[:description]=course.description
        temp[:instructor]=course.instructor
        temp[:price]=course.price
        temp[:phone]=course.phone
        temp[:email]=course.email
        temp[:image_path]=course.image_path.url
        temp[:more_info]=course.more_info
        temp[:condo_id]=course.condo_id
        temp[:created_at]=course.created_at
        temp[:updated_at]=course.updated_at
        courses_data[i] = temp
        #temp[b.status] = b.status
        #facilities[i][:ok] = 'ok'
        i+=1
      end
      return courses_data
    else
      results.each do |course|
        temp = Hash.new
        temp[:id]= course.id
        temp[:name]=course.name
        temp[:description]=course.description
        temp[:instructor]=course.instructor
        temp[:price]=course.price
        temp[:phone]=course.phone
        temp[:email]=course.email
        temp[:image_path]=course.image_path.url
        temp[:more_info]=course.more_info
        temp[:condo_id]=course.condo_id
        temp[:created_at]=course.created_at
        temp[:updated_at]=course.updated_at
        return temp
      end
    end
  end

end

