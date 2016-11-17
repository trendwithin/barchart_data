# require './test/minitest_helper'
# require './test/helper/test_helper'
# require 'fakeweb'
#
# class TestScraper < Minitest::Test
#   include TestHelper
#   def setup
#     @scraper = ::BarchartData::Scraper.new
#     @stream = {
#       ath: './test/test_files/athigh.php',
#       nh:  './test/test_files/newhigh',
#       nl:  './test/test_files/newlow',
#       atl: './test/test_files/alltimelow'
#     }
#   end
#
#   def test_existance
#     assert_instance_of BarchartData::Scraper, @scraper
#   end
#
#   def test_url_stream_for_key_value_pairs
#     assert_equal 4, @scraper.urls.size
#     assert true, @scraper.urls.has_key?(:all_time_high)
#     assert true, @scraper.urls.has_key?(:new_high)
#     assert true, @scraper.urls.has_key?(:new_low)
#     assert true, @scraper.urls.has_key?(:all_time_low)
#     assert true, @scraper.urls.has_value?('http://www.barchart.com/stocks/athigh.php?_dtp1-0')
#     assert true, @scraper.urls.has_value?('http://www.barchart.com/stocks/high.php?_dtp1-0')
#     assert true, @scraper.urls.has_value?('http://www.barchart.com/stocks/low.php?_dtp1=0')
#     assert true, @scraper.urls.has_value?('http://www.barchart.com/stocks/atlow.php?_dtp1-0')
#   end
#
#   def test_get_smart
#     assert_instance_of Mechanize, @scraper.agent
#   end
#
#   def test_fakeweb_using_local_files_returns_nodeset
#     noko_node = fakeweb @scraper, @stream
#     assert_instance_of Nokogiri::XML::NodeSet, noko_node
#   end
#
#   def test_symbols_in_nodeset_return_expected_all_time_highs
#     symbols = fakeweb_to_symbols @scraper, @stream, :all_time_high, :ath
#     assert_instance_of Array, symbols
#     expected = ['AAT', 'LOPE', 'ZMH']
#     expected.each do |e|
#       assert_includes symbols, e
#     end
#   end
#
#   def test_symbols_in_nodeset_return_expected_new_highs
#     symbols = fakeweb_to_symbols @scraper, @stream, :new_high, :nh
#     assert_instance_of Array, symbols
#     expected = ['AAN', 'POST', 'VRTU']
#     expected.each do |e|
#       assert_includes symbols, e
#     end
#   end
#
#   def test_symbols_in_nodeset_return_expected_new_lows
#     symbols = fakeweb_to_symbols @scraper, @stream, :new_low, :nl
#     assert_instance_of Array, symbols
#     assert_equal 144, symbols.size
#     expected = ['ABX', 'DECK', 'ZUMZ']
#     expected.each do |e|
#       assert_includes symbols, e
#     end
#   end
#
#   def test_symbols_in_nodeset_return_expected_all_time_lows
#     symbols = fakeweb_to_symbols @scraper, @stream, :all_time_low, :atl
#     assert_instance_of Array, symbols
#     assert_equal 30, symbols.size
#     expected = ['ABY', 'GNK', 'WPG']
#     expected.each do |e|
#       assert_includes symbols, e
#     end
#   end
#
#   def test_each_key_value_in_urls_returns_expected_stream_by_returning_a_symbol
#     @scraper.urls.each do |sym, url|
#       case sym
#       when :all_time_high
#         assert true, FakeWeb.register_uri(:get, @scraper.urls[sym], :body => @stream[:ath], :content_type => 'text/html')
#         assert true, @scraper.agent.get(@scraper.urls[sym]).search("input")[6].to_s.include?('AAT')
#
#       when :new_high
#         assert true, FakeWeb.register_uri(:get, @scraper.urls[sym], :body => @stream[:nh], :content_type => 'text/html')
#         assert true, @scraper.agent.get(@scraper.urls[sym]).search("input")[6].to_s.include?('VRTU')
#
#       when :new_low
#         assert true, FakeWeb.register_uri(:get, @scraper.urls[sym], :body => @stream[:nl], :content_type => 'text/html')
#         assert true, @scraper.agent.get(@scraper.urls[sym]).search("input")[6].to_s.include?('ZUMZ')
#
#       when :all_time_low
#         assert true, FakeWeb.register_uri(:get, @scraper.urls[sym], :body => @stream[:atl], :content_type => 'text/html')
#         assert true, @scraper.agent.get(@scraper.urls[sym]).search("input")[6].to_s.include?('FRPT')
#       end
#     end
#   end
#
#   def test_looping_through_urls_and_database_insertion
#     @scraper.urls.each do |sym, url|
#       case sym
#       when :all_time_high
#         symbols = fakeweb_to_symbols @scraper, @stream, :all_time_high, :ath
#         symbols.each do |s|
#           AllTimeHigh.create(symbol: s, saved_on: Time.now.to_date.to_s)
#         end
#         assert AllTimeHigh.find_by(symbol: 'LOPE'), !nil
#       when :new_high
#         symbols = fakeweb_to_symbols @scraper, @stream, :new_high, :nh
#
#         symbols.each do |s|
#           NewHigh.create(symbol: s, saved_on: Time.now.to_date.to_s)
#         end
#         assert NewHigh.find_by(symbol: 'POST'), !nil
#       when :new_low
#         symbols = fakeweb_to_symbols @scraper, @stream, :new_low, :nl
#
#         symbols.each do |s|
#           NewLow.create(symbol: s, saved_on: Time.now.to_date.to_s)
#         end
#         assert NewLow.find_by(symbol: 'MRVL'), !nil
#       when :all_time_low
#         symbols = fakeweb_to_symbols @scraper, @stream, :all_time_low, :atl
#
#         symbols.each do |s|
#           AllTimeLow.create(symbol: s, saved_on: Time.now.to_date.to_s)
#         end
#         assert AllTimeLow.find_by(symbol: 'CDE'), !nil
#       end
#     end
#   end
# end
