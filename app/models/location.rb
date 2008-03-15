class Location < ActiveRecord::Base

    attr_accessor :query, :result

    def ll
        "#{lat},#{lng}"
    end
end
