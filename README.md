# BarchartData

BarchartData: Screen Scrape Utility to grab and persist stock releated data.

Current version (0.1.0) extracts All Time Highs.  This project is still in its infancy and will be heavily modified over time.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'barchart_data'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install barchart_data

## Usage

```rails generate barchart_data:install```

```rake db:migrate```

```rails runner bin/barchart```

***Best Run Time:***  7PM PST (2AM GMT) as data stabalizes.

***Be Kind***  Test against the file test/test_files/athigh.php and limit hits against site.

## Prevent Duplicate Records
There should only be one record per symbol per date.


**AllTimeHigh**

    class AllTimeHigh < ActiveRecord::Base
      validates :symbol, uniqueness: { scope: :saved_on }
    end


## Future Features:
*  52-Week High
*  All-Time-Low
*  52-Week Low
*  Current New Highs/Lows
*  Error Handling


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/https://github.com/trendwithin/barchart_data/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contact:
Feel free to contract me with questions, collaborations, features and ideas, refactoring and code improvement etc...
