
class LocationController < ApplicationController
    
    def list
    end

    def new
    end

    def save
      @location = Location.find(params[:location][:id])
      @location.reset_cols
      @location.update_attributes(params[:location])
      @location = Location.find(params[:location][:id])
      @location.geocode
      @route = Route.find(params[:route][:id])
      if (@route.distance > 50.0)
          logger.debug "Do you really ride: #{@route.fmt_distance}kms ?"

      end
      render :partial => 'location'
    end


    def create
        @loc = geocode(params[:location][:query])
        if @loc.save
            render(:action => "show", :id => @loc.id)
        end
        new
    end

    def show
        @loc = Location.find_by_id(params[:id])
    end
end
