class RidersController < ApplicationController  

  before_filter :find_rider, :except => [:index, :new, :create]

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    @rider = Rider.new(:login => params[:rider][:name])
    country = 'AU' # TODO: geocode client's IP
    from = geocode params[:rider][:from_query] + ", #{country}";
    to = geocode params[:rider][:to_query] + ", #{country}";
    check_address from
    check_address to

    if (!@rider.save)
      logger.debug "Could not save rider: #{@rider.id}"
      flash[:notice] = "Could not save rider: #{@rider}"
      render :action => :new
    end

    route = Route.new :from_location_id => from.id, :to_location_id => to.id, :rider_id => @rider.id
    route.save
    redirect_to :controller => 'route', :action => 'confirm', :id => route

  rescue ActiveRecord::RecordInvalid => e
    render :action => 'new'
  end

  def check_address(addr)
    if (!addr.success?)
      flash[:notice] = "Could not find location: #{addr.query}"
      render :new
    end

    logger.debug "Address is success: #{addr.success}, #{addr.full_address}"
    if (!addr.save)
      flash[:notice] = "Could not save location: #{addr}"
      render :new
    end

  end

  def confirm_route

  end

  def index
    @riders = Rider.paginate :order => 'created_at', :page => params[:page]
    logger.debug @riders
  end

  def show
    logger.debug @rider
    route = @rider.route
    logger.debug "Route: #{route}, route.from #{route.from}"
    @from = route.from
    @to = route.to
  end

  def update
    @rider = Rider.find(params[:id])
    if params[:rider][:image]
      @rider.image.create(params[:rider][:image])
    end

    respond_to do |format|
      if @rider.update_attributes(params[:rider])
        flash[:notice] = 'Rider was successfully updated.'
        format.html { redirect_to(@rider) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  protected
  def find_rider
    @rider = Rider.find(params[:id])
  end

end
