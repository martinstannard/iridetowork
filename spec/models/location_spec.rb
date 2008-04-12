
require File.dirname(__FILE__) + '/../spec_helper'

describe Location, "requires a lat and a lng" do

  before(:each) do
    @location = Location.new
  end

  it "should be have errors on lat" do
    @location.should have(1).error_on(:lat)
  end

  it "should be have errors on lng" do
    @location.should have(1).error_on(:lng)
  end

  it "should be have errors on query" do
    @location.should have(1).error_on(:query)
  end

end

describe Location, "should be valid with a lat and a lng and success is true" do

  before(:each) do
    @location = Location.new(:lat => 30.4, :lng => 123.78, :success => true, :query => '2a Oxford St, Rozelle, NSW  2039') 
  end

  it "should be valid " do
    @location.should be_valid
  end

end

describe Location, "should not be valid with a lat and a lng and success is false" do

  before(:each) do
    @location = Location.new(:lat => 30.4, :lng => 123.78, :success => false, :query => '2a Oxford St, Rozelle, NSW  2039') 
  end

  it "should be valid " do
    @location.should_not be_valid
  end

end
