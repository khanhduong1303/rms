class Facility < ActiveRecord::Base
  belongs_to :facility_category
  has_many :time_slots, dependent: :destroy
  has_many :facility_statuses, dependent: :destroy
  has_many :bookings, through: :time_slots

  has_attached_file :image_path, styles: {default: '150x150#'}, default_url: '/images/no-image-11.svg'
  validates_attachment_content_type :image_path, :content_type => /\Aimage\/.*\Z/
  validates_attachment :image_path, size: {:in => 0..3.megabytes}, content_type: {:content_type => /^image\/(jpeg|png|gif|tiff)$/}
  validates :name, :booking_price, :deposit_price, :facility_category_id, presence: true
  validates :name, uniqueness: true

  def currency(val)
    "#{ActionController::Base.helpers.number_to_currency(val)}"
  end
end

