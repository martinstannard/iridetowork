class RidersController < ApplicationController  

  before_filter :find_rider, :except => [:index, :new, :create, :json]

  # render new.rhtml
  def new
  end

  def edit
    @route = Route.find_by_rider_id @rider.id

  end

  def create
    cookies.delete :auth_token
    @rider = Rider.new(:login => params[:rider][:name])
    country = 'AU' # TODO: geocode client's IP
    from = geocode params[:rider][:from_query] + ", #{country}";
    to = geocode params[:rider][:to_query] + ", #{country}";
    check_address from
    check_address to
    if (!from.errors.empty? and !to.errors.empty?) ## TODO: use errors and proper validation here.
      @from = from
      @to = to
      render :action => :new
      return
    end

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
    if (!addr.save)
      logger.debug addr.errors
    end

  end

  def confirm_route

  end

  def index
    @routes = Route.find :all
    respond_to do |format|
      format.json {
        json = Array.new
        @routes.collect {
          |route| json <<  {:id => route.id,
                           :rider => {:name => route.rider.login, :id => route.rider_id},
                           :from =>  {:lat => route.from.lat, :lng => route.from.lng},
                           :to =>    {:lat => route.to.lat, :lng => route.to.lng}}
        }
        render :json => json, :content_type => 'text/javascript', :callback => :paint
      }
      format.html {@riders = Rider.paginate :order => 'created_at', :page => params[:page] }
    end
  end

  def show
    route = @rider.route
    logger.debug "Route: #{route}, route.from #{route.from}"
    @from = route.from
    @to = route.to
  end

  def update
    logger.info params.to_yaml
    @rider = Rider.find(params[:id])
    logger.info @rider

    if params[:image]
      unless params[:image][:uploaded_data].blank?
        image = Image.new params[:image]
        image.save
        @rider.image = image
      end
    end
    
    respond_to do |format|
      logger.info params.to_yaml
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
