require 'harck'

module Harck
  module UsDate
    US_DATE_REGEX = (/(^[0-9]{1,2}[- \/.][0-9]{1,2}[- \/.][0-9]{4})/).freeze

    DATE_TR = ('/\/|\./').freeze

    US_DATE_FORMAT = "%m-%d-%Y".freeze

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
