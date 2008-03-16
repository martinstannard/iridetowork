require File.dirname(__FILE__) + '/../spec_helper'

describe Image do
  before(:each) do
    @image = Image.new
  end

  it "should be valid" do
    @image.should be_valid
  end
end
