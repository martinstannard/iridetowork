include GeoKit::Mappable

class Location < ActiveRecord::Base

    attr_accessor :query, :result
    acts_as_mappable :default_units => :kms

    def ll
        "#{lat},#{lng}"
    end

end
