class Route < ActiveRecord::Base
    belongs_to :rider
    acts_as_geocodable :address => {:postal_code => :from_zip}
end
