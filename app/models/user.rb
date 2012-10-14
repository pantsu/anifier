class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :subscriptions, dependent: :delete_all
  has_many :titles, through: :subscriptions, uniq: true
  has_many :releasers, through: :subscriptions, uniq: true


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      unless auth.provider == 'twitter'
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = user.password_confirmation = Devise.friendly_token
      end
    end
  end
end
