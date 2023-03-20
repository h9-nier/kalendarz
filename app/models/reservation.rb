class Reservation < ApplicationRecord
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates_format_of :phone_number, with: /\A^\d{3}-\d{3}-\d{3}$\z/i


    
    belongs_to :user
end