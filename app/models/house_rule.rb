class HouseRule < ActiveRecord::Base
  belongs_to :houserule_category

  validates :title, :content, presence: true
  validates :title, uniqueness: true
   
  def category_name
    houserule_category.try(:name)
  end
  def category_name=(name)
    self.houserule_category = HouseruleCategory.find_or_create_by(name: name ) if name.present?
  end


end

