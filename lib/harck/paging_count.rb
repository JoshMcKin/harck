require 'harck'
require 'active_support/core_ext/module/delegation'

module Harck
  module PagingCount
    module Querying

      delegate :paging_count, :to =>  :all
    end

    module Relation

      def paging_count(column_name = nil, options = {})
        if (group_values.any? || (distinct_value || (select_values.join(", ") =~ DISTINCT_REGEX)))
          sub_query = column_name.blank? ? self : self.select(column_name)
          @klass.from(sub_query).count(nil, options)
        else
          count(column_name, options)
        end
      end
    end
  end
end
ActiveRecord::Querying.send(:include, Harck::PagingCount::Querying)
ActiveRecord::Relation.send(:include, Harck::PagingCount::Relation)
