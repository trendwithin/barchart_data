require './test/minitest_helper'
require './test/helper/test_helper'
require 'fakeweb'

class TestHighLow < Minitest::Test
  include TestHelper
  def setup
    @scraper = ::BarchartData::HighLowScraper.new
    @stream = { hl: './test/test_files/highlow' }
  end

  def test_existance
    assert_instance_of BarchartData::HighLowScraper, @scraper
  end

  def test_url_stream_key_value_pair
    assert true, @scraper.url.has_key?(:high_low)
    assert true, @scraper.url.has_value?('http://www.barchart.com/stocks/newhilo.php?dwm=d')
  end

  def test_get_smart
    assert_instance_of Mechanize, @scraper.agent
  end

  def test_fakeweb_using_local_files_returns_nodeset
    noko_node = fakeweb_high_low @scraper, @stream
    assert_instance_of Nokogiri::XML::NodeSet, noko_node
  end

  def test_extracting_links_from_noko_node
    links = fakeweb_high_low_links @scraper, @stream
    assert_instance_of Array, links
  end

  def test_striping_of_values_from_links_array
    links = fakeweb_high_low_links @scraper, @stream
    overall_high_low = regex_to_stip_high_low_data_from links
    expected = [212, 304, 74, 238, 54, 214, 37, 168, 44, 195]
    assert_equal expected.sort, overall_high_low.sort
  end

  def test_data_insertion_of_symbols
    links = fakeweb_high_low_links @scraper, @stream
    high_low = regex_to_stip_high_low_data_from links
    HighLow.create(one_month_high: high_low[0], one_month_low: high_low[1],
                   three_month_high: high_low[2], three_month_low: high_low[3],
                   six_month_high: high_low[4], six_month_low: high_low[5],
                   twelve_month_high: high_low[6], twelve_month_low: high_low[7],
                   ytd_high: high_low[8], ytd_low: high_low[8],
                   saved_on: Time.now.strftime("%m/%d/%Y"))

    results = HighLow.find_by(saved_on: Time.now.strftime("%m/%d/%Y"))
    expected = [212, 304, 74, 238, 54, 214, 37, 168, 44, 195]
    assert_equal expected.sort, high_low.sort
  end
end
