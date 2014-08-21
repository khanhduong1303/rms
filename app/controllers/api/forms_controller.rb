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
end

