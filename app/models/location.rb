include GeoKit::Mappable

class Location < ActiveRecord::Base

    attr_accessor :query, :result
    acts_as_mappable :default_units => :kms
    validates_presence_of :lat
    validates_presence_of :lng

    def ll
        "#{lat},#{lng}"
    end
    
  protected
  def validate
    logger.debug "Address is success: #{success}, #{full_address}"    
    errors.add(:query, "Could not locate address from query: #{query}") unless self.success
    logger.debug "Errors #{errors}"
  end
end
