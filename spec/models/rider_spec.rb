require File.dirname(__FILE__) + '/../spec_helper'

describe Rider, "requires some fields" do

  before(:each) do
    @rider = Rider.new()
  end

  it "should be have errors on login" do
    @rider.should have(1).error_on(:login)
  end  
end

