class RidersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_rider, :only => [:show, :suspend, :unsuspend, :destroy, :purge]
  

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @rider = Rider.new(params[:rider])
    route = Route.new(:rider => @rider)
    route.from_zip = params[:rider][:from_zip]
    route.to_zip = params[:rider][:to_zip]
    @rider.routes << route

    raise ActiveRecord::RecordInvalid.new(@rider) unless @rider.valid?
    @rider.register!
    self.current_rider = @rider
    redirect_back_or_default('/')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid => e
    render :action => 'new'
  end

  def activate
    self.current_rider = params[:activation_code].blank? ? :false : Rider.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_rider.active?
      current_rider.activate!
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/')
  end

  def suspend
    @rider.suspend! 
    redirect_to riders_path
  end

  def unsuspend
    @rider.unsuspend! 
    redirect_to riders_path
  end

  def destroy
    @rider.delete!
    redirect_to riders_path
  end

  def purge
    @rider.destroy
    redirect_to riders_path
  end
  
  def index
    @riders = Rider.paginate :order => 'created_at', :page => params[:page]
  end
  
  def show
  end

protected
  def find_rider
    @rider = Rider.find(params[:id])
  end

end
