require 'harck'
require 'harck/constants'

module Harck
  module UsDate
    include Harck::Constants::DateTime
    
    private

    def cast_value(value)
      if value.is_a?(::String) && value =~ US_DATE_REGEX
        Date.strptime(value.tr(DATE_TR,'-'), US_DATE_FORMAT)
       else
       	super value 
      end
    end
  end
end

ActiveRecord::Type::Date.send(:prepend, Harck::UsDate)
