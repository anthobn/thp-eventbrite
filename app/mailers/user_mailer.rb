class UserMailer < ApplicationMailer

  default from: 'dorok92458@corsj.net'

  def welcome_new_user(user)
    @user = user
    @url = "http://localhost:3000"
    mail(to: @user.email, subject:'Bienvenue sur Eventbrite !')
  end
end
