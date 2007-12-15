require File.dirname(__FILE__) + '/../test_helper'

class RiderTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :riders

  def test_should_create_rider
    assert_difference 'Rider.count' do
      rider = create_rider
      assert !rider.new_record?, "#{rider.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_login
    assert_no_difference 'Rider.count' do
      u = create_rider(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'Rider.count' do
      u = create_rider(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'Rider.count' do
      u = create_rider(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'Rider.count' do
      u = create_rider(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    riders(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal riders(:quentin), Rider.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    riders(:quentin).update_attributes(:login => 'quentin2')
    assert_equal riders(:quentin), Rider.authenticate('quentin2', 'test')
  end

  def test_should_authenticate_rider
    assert_equal riders(:quentin), Rider.authenticate('quentin', 'test')
  end

  def test_should_set_remember_token
    riders(:quentin).remember_me
    assert_not_nil riders(:quentin).remember_token
    assert_not_nil riders(:quentin).remember_token_expires_at
  end

  def test_should_unset_remember_token
    riders(:quentin).remember_me
    assert_not_nil riders(:quentin).remember_token
    riders(:quentin).forget_me
    assert_nil riders(:quentin).remember_token
  end

  def test_should_remember_me_for_one_week
    before = 1.week.from_now.utc
    riders(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil riders(:quentin).remember_token
    assert_not_nil riders(:quentin).remember_token_expires_at
    assert riders(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    riders(:quentin).remember_me_until time
    assert_not_nil riders(:quentin).remember_token
    assert_not_nil riders(:quentin).remember_token_expires_at
    assert_equal riders(:quentin).remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    riders(:quentin).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil riders(:quentin).remember_token
    assert_not_nil riders(:quentin).remember_token_expires_at
    assert riders(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_register_passive_rider
    rider = create_rider(:password => nil, :password_confirmation => nil)
    assert rider.passive?
    rider.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    rider.register!
    assert rider.pending?
  end

  def test_should_suspend_rider
    riders(:quentin).suspend!
    assert riders(:quentin).suspended?
  end

  def test_suspended_rider_should_not_authenticate
    riders(:quentin).suspend!
    assert_not_equal riders(:quentin), Rider.authenticate('quentin', 'test')
  end

  def test_should_unsuspend_rider
    riders(:quentin).suspend!
    assert riders(:quentin).suspended?
    riders(:quentin).unsuspend!
    assert riders(:quentin).active?
  end

  def test_should_delete_rider
    assert_nil riders(:quentin).deleted_at
    riders(:quentin).delete!
    assert_not_nil riders(:quentin).deleted_at
    assert riders(:quentin).deleted?
  end

protected
  def create_rider(options = {})
    Rider.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
