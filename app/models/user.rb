class User < ActiveRecord::Base
  attr_accessible :email, :name
  before_validation :generate_referring_code!, :on => :create
  validates_presence_of :email

  def generate_referring_code!
    begin
      self.referring_code = SecureRandom.hex(3)
    end while User.find_by_referring_code(self.referring_code).present?
  end

  def get_referring_url
    LINQUET_MINI_URL + "/?r=" + self.referring_code
  end
end
