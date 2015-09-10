require './test/minitest_helper'
require 'fakeweb'

class TestNewHigh < Minitest::Test

  def setup
    @nh = BarchartData::NewHigh.new
    @stream = "./test/test_files/newhigh"
    @entry = NewHigh.first
  end

  def test_it_should_be_valid
    assert_instance_of BarchartData::NewHigh, @nh
  end

  def test_url
    assert_equal 'http://www.barchart.com/stocks/high.php', @nh.url
  end

  def test_agent
    assert_instance_of Mechanize, @nh.agent
  end

  def test_fakeweb_using_local_test_file_returns_nodeset
   FakeWeb.register_uri(:get, @nh.url, :body => @stream, :content_type => 'text/html')
   noko_node = @nh.agent.get(@nh.url).search("input")
   assert_instance_of Nokogiri::XML::NodeSet, noko_node
  end

  def test_nodeset_symbols_include_expected_values
    FakeWeb.register_uri(:get, @nh.url, :body => @stream, :content_type => 'text/html')
    noko_node = noko_node = @nh.agent.get(@nh.url).search("input")[6].to_s
    strip_tickers = noko_node.scan(/[A-Z]+,[^a-z]+[A-Z]/)
    symbols = strip_tickers[0].split(',')
    assert_instance_of Array, symbols
    expected = ['AAN', 'POST', 'VRTU']
    expected.each do |e|
      assert_includes symbols, e
    end
  end

  def test_current_data_in_model
    assert_equal NewHigh.first.symbol, 'XYX'
    assert_equal NewHigh.first.saved_on, Time.now.to_date.to_s
  end

    def test_data_model_validation_for_symbol
    @entry.symbol = '    '
    refute @entry.valid?
  end

  def test_data_model_validation_for_saved_on
    @entry.saved_on = '         '
    refute @entry.valid?
  end

  def test_data_model_validation_for_duplicates
    refute NewHigh.create(symbol: 'XYX', saved_on: Time.now.to_date.to_s).valid?
  end

  def test_db_insertion
    FakeWeb.register_uri(:get, @nh.url, :body => @stream, :content_type => 'text/html')
    noko_node = noko_node = @nh.agent.get(@nh.url).search("input")[6].to_s
    strip_tickers = noko_node.scan(/[A-Z]+,[^a-z]+[A-Z]/)
    symbols = strip_tickers[0].split(',')

    symbols.each do |s|
      NewHigh.create(symbol: s, saved_on: Time.now.to_date.to_s)
    end
    assert NewHigh.find_by(symbol: 'AAN'), !nil
    assert NewHigh.find_by(symbol: 'DY'), !nil
    assert NewHigh.find_by(symbol: 'VRTU'), !nil
  end
end
