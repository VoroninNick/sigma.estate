class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :username, :email, :password

  has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "80x80#" }, :default_url => "/images/:style/missing.png"
 validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
