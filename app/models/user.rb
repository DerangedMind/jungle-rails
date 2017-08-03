class User < ActiveRecord::Base

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  before_create :email_must_not_exist

  has_secure_password

  private

  def email_must_not_exist
    @user = User.find_by_email(email)
    if @user.present?
      errors.add(:email, 'already exists')
      throw(:abort)
    end
  end

end
