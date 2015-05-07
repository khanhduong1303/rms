class Api::FormsController < Api::ApiController
  def index
    begin
      @form_categories = FormCategory.where(condo_id: params[:condo_id])
    rescue Exception => e
      @form_categories = nil
    end
    unless @form_categories.nil?
      @forms = []
      @form_categories.each do |form_category|
        temp = []
        form_category.forms.each do |form|
          temp << {title: form.title, form_path: form.form_path.exists? ? form.form_path.url : ''}
        end
        @forms << {form_category_name: form_category.name, total: form_category.forms.size, forms: temp}
      end
      render json: {status: 'success', message: 'Found forms', total: @form_categories.length, results: @forms}, status: :ok
    else
      render json: {status: 'failed', message: 'Not found forms', results: {}}, status: :not_found
    end
  end

  def get_forms
    if !params[:condo_id].nil?
      limit = params[:limit].blank? ? 5 : params[:limit].to_i
      page = params[:page].blank? ? 1 : params[:page].to_i
      forms = proccess_forms Condo.find(params[:condo_id]).forms.limit(limit).offset((page - 1) * limit).order(created_at: :desc)
      return render json: PublicFunction.data_json('success', 'List forms', Condo.find(params[:condo_id]).forms.size, forms)
    else
      return render json: PublicFunction.data_json('failed', 'Missing condo_id parameter', 0, nil)
    end
  end

  def count_forms
    if !params[:condo_id].nil?
      return render json: PublicFunction.data_json('success', 'List facility', 1, Condo.find(params[:condo_id]).forms.size)
    else
      return render json: PublicFunction.data_json('failed', 'Missing condo_id parameter', 0, nil)
    end
  end

  private
  def proccess_forms forms = nil
    _forms = []
    unless forms.nil?
      forms.each do |f|
      _forms << {title: f.title, form_path: f.form_path.exists? ? f.form_path.url : ''}
      end
    end
    return _forms
  end

end

