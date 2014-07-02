class User < ActiveRecord::Base
attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable 

belongs_to :condo
#setup avartar
has_attached_file :avatar, :styles => { :medium => "200x200>", :small => "140x140>", :big => "250x250>" }, :default_url => "/images/:style/missing.png"
validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
validates_attachment :avatar,
    :size => { :in => 0..3.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }
    
validates :username, :uniqueness => {:case_sensitive => false}
 def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where([" lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
 end



end
