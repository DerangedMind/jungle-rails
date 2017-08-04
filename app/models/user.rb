class User < ActiveRecord::Base

  has_many :reviews
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :admin, default: false
  #before_create :email_must_not_exist

  has_secure_password
end
