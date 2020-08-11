class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #after_create :welcome_new_user

  has_many :attendances
  has_many :events, through: :attendances
  has_many :events_admin, foreign_key: 'user_admin_id', class_name: "Event"

  def welcome_new_user
    UserMailer.welcome_new_user(self).deliver_now
  end
end
