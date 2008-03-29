class RouteController < ApplicationController

  def confirm
    find_route
    @from = @route.from
    @to = @route.to
    logger.debug "Route: #{@from} #{@to}"
  end

  def update
    route = params[:route]
    @route = Route.find_by_id route[:id]
    @from = @route.from
    @to = @route.to
    geocode_location @from, route[:from]
    geocode_location @to, route[:to]
    render :template => 'route/confirm.haml'
  end

  def find_route
    @route = Route.find_by_id params[:id]
  end
end
