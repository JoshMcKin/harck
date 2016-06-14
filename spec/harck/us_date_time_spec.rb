require 'spec_helper'
require 'harck/us_date_time'

describe Harck::UsDateTime do

  let(:user) { User.new(datetime: "02-12-2014 12:01") }

  it "should handle US formatted dates" do
    expect(user.datetime).to eql(User.new(datetime: "2014-02-12 12:01").datetime)
  end

end
