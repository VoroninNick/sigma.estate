class User < ActiveRecord::Base
  # self.table_name = :users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :username, :email, :password, :subscribe, :avatar

  # has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "80x80#" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                             url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: '<get_use_rake_secret>'
  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..1.megabytes }
end
