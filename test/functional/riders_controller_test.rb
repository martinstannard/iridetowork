require File.dirname(__FILE__) + '/../test_helper'
require 'riders_controller'

# Re-raise errors caught by the controller.
class RidersController; def rescue_action(e) raise e end; end

class RidersControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :riders

  def setup
    @controller = RidersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_allow_signup
    assert_difference 'Rider.count' do
      create_rider
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'Rider.count' do
      create_rider(:login => nil)
      assert assigns(:rider).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'Rider.count' do
      create_rider(:password => nil)
      assert assigns(:rider).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'Rider.count' do
      create_rider(:password_confirmation => nil)
      assert assigns(:rider).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'Rider.count' do
      create_rider(:email => nil)
      assert assigns(:rider).errors.on(:email)
      assert_response :success
    end
  end
  
  def test_should_activate_user
    assert_nil Rider.authenticate('aaron', 'test')
    get :activate, :activation_code => riders(:aaron).activation_code
    assert_redirected_to '/'
    assert_not_nil flash[:notice]
    assert_equal riders(:aaron), Rider.authenticate('aaron', 'test')
  end
  
  def test_should_not_activate_user_without_key
    get :activate
    assert_nil flash[:notice]
  rescue ActionController::RoutingError
    # in the event your routes deny this, we'll just bow out gracefully.
  end

  def test_should_not_activate_user_with_blank_key
    get :activate, :activation_code => ''
    assert_nil flash[:notice]
  rescue ActionController::RoutingError
    # well played, sir
  end

  protected
    def create_rider(options = {})
      post :create, :rider => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire', :password_confirmation => 'quire' }.merge(options)
    end
end
