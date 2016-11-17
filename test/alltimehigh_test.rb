# require './test/minitest_helper'
# require 'fakeweb'
#
# class TestAllTimeHigh < Minitest::Test
#   def setup
#     @ath = ::BarchartData::AllTimeHigh.new
#     @stream = "./test/test_files/athigh.php"
#     @entry = AllTimeHigh.first
#   end
#
#   def test_it_should_be_valid
#     assert_instance_of ::BarchartData::AllTimeHigh, @ath
#   end
#
#   def test_url
#     assert_equal 'http://www.barchart.com/stocks/athigh.php?_dtp1-0', @ath.url
#   end
#
#   def test_agent
#     assert_instance_of Mechanize, @ath.agent
#   end
#
#   def test_fakeweb_using_local_test_file_returns_nodeset
#    FakeWeb.register_uri(:get, @ath.url, :body => @stream, :content_type => 'text/html')
#    noko_node = @ath.agent.get(@ath.url).search("input")
#    assert_instance_of Nokogiri::XML::NodeSet, noko_node
#   end
#
#   def test_nodeset_symbols_include_expected_values
#     FakeWeb.register_uri(:get, @ath.url, :body => @stream, :content_type => 'text/html')
#     noko_node = noko_node = @ath.agent.get(@ath.url).search("input")[6].to_s
#     strip_tickers = noko_node.scan(/[A-Z]+,[^a-z]+[A-Z]/)
#     symbols = strip_tickers[0].split(',')
#     assert_instance_of Array, symbols
#     expected = ['AAT', 'LOPE', 'ZMH']
#     expected.each do |e|
#       assert_includes symbols, e
#     end
#   end
#
#   def test_current_data_in_model
#     assert_equal AllTimeHigh.first.symbol, 'ABC'
#     assert_equal AllTimeHigh.first.saved_on, Time.now.to_date.to_s
#   end
#
#   def test_data_model_validation_for_symbol
#     @entry.symbol = '    '
#     refute @entry.valid?
#   end
#
#   def test_data_model_validation_for_saved_on
#     @entry.saved_on = '         '
#     refute @entry.valid?
#   end
#
#   def test_db_insertion
#     FakeWeb.register_uri(:get, @ath.url, :body => @stream, :content_type => 'text/html')
#     noko_node = noko_node = @ath.agent.get(@ath.url).search("input")[6].to_s
#     strip_tickers = noko_node.scan(/[A-Z]+,[^a-z]+[A-Z]/)
#     symbols = strip_tickers[0].split(',')
#
#     symbols.each do |s|
#       AllTimeHigh.create(symbol: s, saved_on: Time.now.to_date.to_s)
#     end
#     assert AllTimeHigh.find_by(symbol: 'LOPE'), !nil
#   end
# end
#
