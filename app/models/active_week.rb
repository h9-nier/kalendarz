class ActiveWeek < ApplicationRecord
    after_initialize :set_defaults

    private
  
    def set_defaults
      self.first_day ||= Date.today.beginning_of_week
    end
end