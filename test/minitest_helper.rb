$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'barchart_data'
require 'minitest/autorun'
require 'barchart_data/alltimehigh'
ActiveRecord::Base.establish_connection(:adapter => "sqlite3",
                                       :database => File.dirname(__FILE__) + "/barchart.sqlite3")

load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'
load File.dirname(__FILE__) + '/support/data.rb'

