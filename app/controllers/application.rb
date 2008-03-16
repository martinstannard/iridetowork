include GeoKit::Geocoders

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  geocode_ip_address

  ## TODO: move these to a helper
  def geocode(query)
    h = geocode_hash(query)
    loc = Location.new h
    loc.query = query
    loc.result = h
    loc
  end

  def geocode_location(location, query)
    h = geocode_hash(query)
    location.update_attributes h
    location.save
  end

  def geocode_hash(query)
    ip_location = session[:geo_location] != nil ? session[:geo_location].city: "" ;
    res = MultiGeocoder.geocode(query + ip_location)
    h = res.to_hash
    m = {:ll => '', :is_us? => ''}
    h.delete_if {|key, value| m.has_key?(key)}
  end

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e29fd7e12754ac6b0c8da37082ea3575'
end
