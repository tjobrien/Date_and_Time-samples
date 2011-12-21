class Event < ActiveRecord::Base
  
  validates :start_at_hour, :start_at_minute,  :numericality => { :only_integer => true }
  validates_date  :start_at_date, :invalid_date_message => "Must be a Valid Date in YY-MM-DD format"
  validates :duration, :presence => { :message => "Please Select an Event duration" }

  DURATIONS = [[ "half an hour", 30], ["hour", 60], ["hour - 15 min", 75],["hour and a half", 90 ], ["hour - 45 min", 105 ], ["two hours", 120]]
  
  before_save :date_parser #works good except in the case of all_day.  The has_event_calendar method in the gem has a method that is called in the 
                           # in the before_save callback too. It appears to go first as the the start_at is nil when that method is called.
                           # I put the has_event_calendar method after this and the dates are validated and parsed correctly.
  
  #after_validation :date_parser - this works with all_day true and a valid date,  but
  #validations including validates_date doesn't fire.
  #before_save :update_date
  
  has_event_calendar
  
  private
  def date_parser
        self.start_at_date = Chronic::parse(self.start_at_date_before_type_cast).to_date # if attribute_present?("start_at_date")
        self.start_at = Chronic.parse("#{self.start_at_date} #{self.start_at_hour}:#{self.start_at_minute} #{self.am_pm}")
        self.end_at = self.duration.minutes.since self.start_at unless self.all_day        
  end
  def update_date
    self.start_at = Time.now
  end
end
