require 'spec_helper'
require 'harck/us_date'

describe Harck::UsDate do

  let(:user) { User.new(date: "02-12-2014") }

  it "should handle US formatted dates" do
    expect(user.date).to eql("2014-02-12".to_date)
  end
end
