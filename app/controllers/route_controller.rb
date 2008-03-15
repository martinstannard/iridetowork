class RouteController < ApplicationController

    def confirm
        find_route
        @from = @route.from
        @to = @route.to
        logger.debug "Route: #{@from} #{@to}"
    end

    def find_route
        @route = Route.find_by_id params[:id]
    end
end
