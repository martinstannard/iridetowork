
require File.dirname(__FILE__) + '/../spec_helper'

describe Location, "requires a lat and a lng" do

  before(:each) do
    @location = Location.new
  end

  it "should be have errors on la" do
    @location.should have(1).error_on(:lat)
  end

  it "should be have errors on " do
    @location.should have(1).error_on(:lng)
  end

end

describe Location, "should be valid with a lat and a lng" do

  before(:each) do
    @location = Location.new(:lat => 30.4, :lng => 123.78) 
  end

  it "should be valid " do
    @location.should be_valid
  end

end
