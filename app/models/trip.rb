require 'chronic'

class Trip < ActiveRecord::Base
  
  has_many :trip_participations,
   inverse_of: :trip
  
  has_many :users, 
    through: :trip_participations


  # the order here matters!!
  has_many :trip_mountains, 
    inverse_of: :trip
  has_many :mountains, 
    through: :trip_mountains, 
      inverse_of: :trips

  mount_uploader :image, ImageUploader

  validates_presence_of :title
  validates_presence_of :date
  validate :date_within_range, on: :create

  def chronic_date
    self.date
  end

  def chronic_date=(stringy_date)
    self.date = Chronic.parse(stringy_date)
  end

  def date_within_range
    if date.nil?
      errors.add(:date, "can't be blank")
    else
      if date < Date.today.years_ago(100)
        errors.add(:chronic_date, "can't be that far in the past")
        errors.add(:date, "can't be that far in the past")
      elsif date > Date.today
        errors.add(:chronic_date, "can't be in the future")
        errors.add(:date, "can't be in the future")
      end
    end
  end

end
