# Harck [![Build Status](https://travis-ci.org/JoshMcKin/harck.svg?branch=master)](https://travis-ci.org/JoshMcKin/harck)

Hacks for ActiveRecord

This library contains hacks for ActiveRecord I have found useful over time. The hacks are not for everyone and should be used with caution.

## Installation

Add this line to your application's Gemfile:

```ruby

 # To require all hacks
 gem 'harck'

```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install harck

Finally create a harck.rb to config/initializer and require the hacks

```
require 'harck/all' # requires all

# or
require 'harck/pagin_count' # requires only paging count

```

## Features

[Harck::Count](https://github.com/JoshMcKin/harck#harckcount) - Count + Group queries run as sub-queries

[Harck::PagingCount](https://github.com/JoshMcKin/harck#harckpagingcount) - Count + Group safe count query for paging

[Harck::ScrubNumeric](https://github.com/JoshMcKin/harck#harckscrubnumeric) - Scrub non-numeric characters before setting numeric data types

[Harck::UsDate & Harck::UsDateTime](https://github.com/JoshMcKin/harck#harckusdate--harckusdatetime) - Try to parse US formatted dates correctly

### Harck::Count

If you have used the ActiveRecord query method `.group` with a paging gem you've probably encountered some problems. When used with `.group`, `.count` returns a hash. In order for paging to work, you must get the length of the hash to determine your total result set. While the hash "feature" sounds great, if you have a large data set, and setup paging you may discover your app is devouring memory, which is always fun to debug. You may have also had issues with unexpected count results if you had DISTINCT set in your select statement and expected AR to respect it.

The Count hack forces all `.count` calls on ActiveRecord::Relations with `.group` values or with distinct select statements to perform a subquery for the dataset which is placed in the FROM statement for the count.

	```
	2.3.0 :001 > require "harck/count"
	 => true
	
	2.3.0 :002 > User.group(:name).count
    (0.4ms)  SELECT COUNT(*) FROM (SELECT `users`.`name` FROM `users` GROUP BY `users`.`name`) from_subquery_for_count

	2.3.0 :003 > User.select("DISTINCT(name)").count
	(0.4ms)  SELECT COUNT(*) FROM (SELECT DISTINCT(name) FROM `users`) from_subquery_for_count

	2.3.0 :004 > User.select(:name).distinct.count
	(0.4ms)  SELECT COUNT(*) FROM (SELECT DISTINCT(name) FROM `users`) from_subquery_for_count

	```

If you find you like this hack but need to perform a COUNT on a GROUP BY you can still achieve your goal by using `.pluck('COUNT(foo)')[0]`

### Harck::PagingCount

If you do not want change the default functionality of `.count` but do want a work around COUNT for paging you can use `.paging_count`, which will always return an integer. You may have to patch your favorite paging gem but at least your app won't be brought to its knees by a `COUNT` + `GROUP BY` query that returns a hash with 2 million items.

	```
	2.3.0 :001 > require "harck/paging_count"
	=> true

	2.3.0 :002 > User.group(:name).paging_count
	(0.04ms)  SELECT COUNT(*) FROM (SELECT `users`.* FROM `users` GROUP BY `users`.`name`) subquery

	```

### Harck::ScrubNumeric

Does your ActiveRecord model accept money strings for numeric attributes? Does your app have a various ugly filters to remove unwanted characters from numeric strings. ScrubNumeric is the hack for you.

	```
	2.3.0 :001 > require "harck/scrub_numeric"
	=> true

	2.3.0 :002 > 2.3.0 :013 > user = User.new(money: "$123.12 ", :clicks => "have 2")
    => #<User id: nil, name: nil, clicks: 2, money: #<BigDecimal:7fee83aab6c0,'0.12312E3',18(27)>> 

    2.3.0 :013 > user.money.to_s
 	=> "123.12" 

	```

### Harck::UsDate & Harck::UsDateTime

For me, without fail, one of the first causes for date time inconsistencies when working with outside data sources has been US date format parsing. The Harck::UsDate and Harck::UsDateTime hacks allow ActiveRecord to correctly parse US date formats.

	```
	2.3.0 :001 > require "harck/us_date"
	=> true

	2.3.0 :002 > 2.3.0 :013 > user = User.new(date: "02-12-2014")
    => #<User id: nil, name: nil, clicks: 0, money: nil, date = "2014-02-12"> 

    2.3.0 :003 > user.date
 	=> Fri, 12 Feb 2016 

 	2.3.0 :001 > require "harck/us_date_time"
	=> true

	2.3.0 :002 > 2.3.0 :013 > user = User.new(datetime: "02-12-2014 02:55 pm")
    => #<User id: nil, name: nil, clicks: 0, money: nil, datetime = "2014-12-02 14:55:00"> 

    2.3.0 :007 > user.datetime
 	=> 2014-12-02 14:55:00 UTC

	```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/harck.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

