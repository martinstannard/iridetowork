require File.dirname(__FILE__) + '/../spec_helper'

describe Rider, "requires a lat and a lng" do

  before(:each) do
    @rider = Rider.new
  end

  it "should be have errors on lat" do
    @rider.should have(1).error_on(:lat)
  end

  it "should be have errors on lng" do
    @rider.should have(1).error_on(:lng)
  end

  it "should be have errors on query" do
    @rider.should have(1).error_on(:query)
  end

end

