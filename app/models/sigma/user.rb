class Sigma::User < ActiveRecord::Base

  self.table_name = :sigma_users
  attr_accessible *attribute_names
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :first_name, :last_name, :middle_name, :phone_number, :email, :password, :subscribe, :avatar

  # has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "80x80#" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                             url: '//crm.sigma.estate/system/:class/:attachment/:id_partition/:style/:basename.:extension',
                             path: ':rails_root/../../development/public/system/:class/:attachment/:id_partition/:style/:basename.:extension',
                             hash_secret: '<get_use_rake_secret>'
  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..1.megabytes }


  # def avatar_url(style)
  #   "//crm.sigma.estate#{avatar.try(&:url)}"
  # end

  has_many :authorizations, foreign_key: :sigma_users_id
  has_and_belongs_to_many :favorites, class_name: Sigma::Apartment, join_table: :favorites

  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      user = current_user || Sigma::User.where('email = ?', auth["info"]["email"]).first
      if user.blank?
        user = Sigma::User.new
        user.password = Devise.friendly_token[0,10]
        user.name = auth.info.name
        user.email = auth.info.email
        if auth.provider == "twitter"
          user.save(:validate => false)
        else
          user.save
        end
      end
      authorization.username = auth.info.nickname
      authorization.user_id = user.id
      authorization.save
    end
    authorization.user
  end
end
