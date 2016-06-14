require 'harck'

module Harck
  module ScrubNumeric
    SCRUB_NUMBER_STRING_REGEX = /[^0-9\.\+\-]/.freeze
    
    def type_cast(value)
      if value.is_a? ::String
        value = value.gsub(SCRUB_NUMBER_STRING_REGEX,'')
      end
      super(value)
    end
  end
end
ActiveRecord::Type::BigInteger.send(:prepend, Harck::ScrubNumeric)
ActiveRecord::Type::Decimal.send(:prepend, Harck::ScrubNumeric)
ActiveRecord::Type::DecimalWithoutScale.send(:prepend, Harck::ScrubNumeric)
ActiveRecord::Type::Float.send(:prepend, Harck::ScrubNumeric)
ActiveRecord::Type::Integer.send(:prepend, Harck::ScrubNumeric)
