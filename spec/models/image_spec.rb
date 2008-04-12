require File.dirname(__FILE__) + '/../spec_helper'

describe Image do
  before(:each) do
    @image = Image.new
  end

  it "should be valid" do
    @image.should have(2).error_on(:size)
  end

  it "should be valid" do
    @image.should have(2).error_on(:content_type)
  end
end
