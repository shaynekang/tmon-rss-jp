require 'spec_helper'

describe "Our first test" do
  it "should be passed" do
    (1+1).should == 2
    (2+3).should == 5
  end
end