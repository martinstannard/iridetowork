class Route < ActiveRecord::Base
    belongs_to :rider
    has_many   :locations

    def from
        logger.debug "Getting From location: #{from_location_id}"
        Location.find_by_id from_location_id
    end
    def to
        Location.find_by_id to_location_id
    end

    def distance
        from.distance_to to
    end

    def fmt_distance
        "%.3f" % distance
    end

end
