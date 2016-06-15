require 'harck'
require 'harck/constants'

module Harck
  module UsDateTime
    include Harck::Constants::DateTime

    private

    def cast_value(value)
      if value.is_a?(::String) && value =~ US_DATE_REGEX
        value = us_date_to_iso_str(value)
      end
      super value
    end

    def us_date_to_iso_str(value)
      date_split = value.split(US_DATE_REGEX)
      time = date_split[2]
      date = date_split[1]
      date_split = date.split(SPLIT_DATE_REGEX)
      "#{date_split[2]}-#{date_split[0]}-#{date_split[1]}#{time}"
    end
  end
end

ActiveRecord::Type::DateTime.send(:prepend, Harck::UsDateTime)
