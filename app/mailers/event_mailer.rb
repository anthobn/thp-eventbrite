class EventMailer < ApplicationMailer
  def new_attendance(attendance)
    @attendance = attendance
    @url = "http://localhost:3000"
    mail(to: @attendance.user.email, subject:"Eventbrite - Nouvelle participation à l'évènement #{@attendance.event.title} !")
  end
end
