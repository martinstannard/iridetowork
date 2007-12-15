class RiderObserver < ActiveRecord::Observer
  def after_create(rider)
    RiderMailer.deliver_signup_notification(rider)
  end

  def after_save(rider)
  
    RiderMailer.deliver_activation(rider) if rider.pending?
  
  end
end
