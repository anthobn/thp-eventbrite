class EventMailer < ApplicationMailer
  def new_attendance(attendance)
    @attendance = attendance
    @url = "https://murmuring-temple-89689.herokuapp.com"
    mail(to: @attendance.user.email, subject:"Eventbrite - Nouvelle participation à l'évènement #{@attendance.event.title} !")
  end
end
