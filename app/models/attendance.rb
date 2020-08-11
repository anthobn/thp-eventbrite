class Attendance < ApplicationRecord
  #after_create :new_attendance

  belongs_to :user
  belongs_to :event

  def new_attendance
    EventMailer.new_attendance(self).deliver_now
  end
end
