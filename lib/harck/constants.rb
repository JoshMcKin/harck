module Harck
  module Constants
    module Count
      DISTINCT_REGEX = /\s*DISTINCT[\s(]+/i.freeze
    end

    module DateTime
      US_DATE_REGEX = (/(^[0-9]{1,2}[- \/.][0-9]{1,2}[- \/.][0-9]{4})/).freeze

      DATE_TR = ('/\/|\./').freeze

      US_DATE_FORMAT = "%m-%d-%Y".freeze

      SPLIT_DATE_REGEX = (/\-|\/|\./).freeze
    end
  end
end
