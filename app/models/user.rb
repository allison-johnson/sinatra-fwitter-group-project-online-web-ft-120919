class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  
  def slug 
    str = self.username
    arr = str.split(" ")
    arr.map{|word| word.downcase}.join("-")
  end #slug

  def self.find_by_slug(slug_name)
    self.all.find{|user| user.slug == slug_name}
  end #self.find_by_slug
end #class
