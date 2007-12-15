class RiderMailer < ActionMailer::Base
  def signup_notification(rider)
    setup_email(rider)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://YOURSITE/activate/#{rider.activation_code}"
  
  end
  
  def activation(rider)
    setup_email(rider)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://YOURSITE/"
  end
  
  protected
    def setup_email(rider)
      @recipients  = "#{rider.email}"
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE] "
      @sent_on     = Time.now
      @body[:rider] = rider
    end
end
