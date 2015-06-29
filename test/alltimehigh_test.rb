require './test/minitest_helper'

class TestAllTimeHigh < Minitest::Test
  def setup
    @ath = ::BarchartData::AllTimeHigh.new
    @stream = "./test/test_files/athigh.php"
  end

  def test_it_should_be_valid
    assert_instance_of ::BarchartData::AllTimeHigh, @ath
  end

  def test_url
    skip
    assert_equal 'http://www.barchart.com/stocks/athigh.php?_dtp1-0', @ath.url
  end

  def test_agent
    assert_instance_of Mechanize, @ath.agent
  end

  def test_fakeweb_using_local_test_file_returns_nodeset
   FakeWeb.register_uri(:get, @ath.url, :body => @stream, :content_type => 'text/html')
   noko_node = @ath.agent.get(@ath.url).search("input")
   assert_instance_of Nokogiri::XML::NodeSet, noko_node
  end

  def test_symbols_include_expected_values
    FakeWeb.register_uri(:get, @ath.url, :body => @stream, :content_type => 'text/html')
    noko_node = noko_node = @ath.agent.get(@ath.url).search("input")[6].to_s
    strip_tickers = noko_node.scan(/[A-Z]+,[^a-z]+[A-Z]/)
    symbols = strip_tickers[0].split(',')
    assert_instance_of Array, symbols
    expected = ['AAT', 'LOPE', 'ZMH']
    expected.each do |e|
      assert_includes symbols, e
    end
  end
end

