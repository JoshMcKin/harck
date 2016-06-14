require 'spec_helper'
require 'harck/count'

describe Harck::Count do

  before(:each) do
    User.delete_all
    10.times do
      User.create(name: "Bob")
      User.create(name: "Stewart")
    end
  end

  context "with .group" do

    it "should return an integer" do
      expect(User.group(:name).count).to eql(2)
    end

  end

  context "with DISTINCT in .select" do

    it "should return an integer" do
      expect(User.select('DISTINCT(name)').count).to eql(2)
    end

  end

  context "with .distinct set" do

    it "should return an integer" do
      expect(User.select(:name).distinct.count).to eql(2)
    end

  end

end
