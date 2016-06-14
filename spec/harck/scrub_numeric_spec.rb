require 'spec_helper'
require 'harck/scrub_numeric'

describe Harck::ScrubNumeric do

  let(:user) { User.new(money: "$123.00", :clicks => "have 2") }

  it "should scrub decimal" do
    expect(user.money.to_f).to eql(123.0)
  end

  it "should scrub integer" do
    expect(user.clicks).to eql(2)
  end

end
