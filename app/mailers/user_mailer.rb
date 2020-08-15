class UserMailer < ApplicationMailer

  def welcome_new_user(user)
    @user = user
    @url = "https://murmuring-temple-89689.herokuapp.com"
    mail(to: @user.email, subject:'Bienvenue sur Eventbrite !')
  end
end
