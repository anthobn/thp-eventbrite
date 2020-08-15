class Event < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances
  belongs_to :user_admin, class_name: "User"

  validates :start_date, presence: true, if: :mydate_is_correct_date?
  validates :duration, presence: true, numericality: { only_integer: true }, if: :multiple_of_5?
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000  }
  validates :price, presence: true, numericality: { only_integer: true }, inclusion: { :in => 0..1000, message: "Please enter an allowed price between 0 - 1000" }
  validates :location, presence: true


  def mydate_is_correct_date?
    if !self.start_date.is_a?(ActiveSupport::TimeWithZone)
      errors.add(:date, 'must be a valid date') 
      return false
    end

    if self.start_date < Time.now
      errors.add(:date, 'must be a date in the futur')
    end
  end

  def multiple_of_5?
    if self.duration && self.duration % 5 == 0
      return true
    else
      errors.add(:duration, 'must be a multiple of 5')
    end
  end

  def is_free?
    return true if self.price == 0
    return false
  end

end
