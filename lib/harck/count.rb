module Harck
  module Count
    DISTINCT_REGEX = /\s*DISTINCT[\s(]+/i.freeze

    private

    def perform_calculation(operation, column_name, options = {})
      operation = operation.to_s.downcase
      if (operation == "count" && (group_values.any? || (distinct_value || (select_values.join(", ") =~ DISTINCT_REGEX))))
        @klass.from(self).count(column_name)
      else
        super operation, column_name, options
      end
    end
  end
end
ActiveRecord::Relation.send(:prepend, Harck::Count)
