$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'vcr'
require 'mechanize'
require 'active_record'
require 'byebug'

require 'barchart_scripts/barchart_connection'
require 'barchart_scripts/scrape_new_highs_new_lows'
require 'barchart_scripts/scrape_new_highs'
# require 'barchart_data'
# require 'barchart_data/alltimehigh'
# require 'barchart_data/newhigh'
# require 'barchart_data/scraper'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3",
                                       :database => File.dirname(__FILE__) + "/barchart.sqlite3")

load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'
load File.dirname(__FILE__) + '/support/data.rb'

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'test/test_files/vcr_cassettes'
  config.hook_into :webmock
end
