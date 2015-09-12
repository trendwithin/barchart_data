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
    strip_links = []
    regex_the_links = []
    overall_high_low = []

    links.each do |a|
      strip_links.push(a.to_s)
    end

    strip_links.slice!(0..3)
    strip_links.shift(6)
    strip_links.each { |e| regex_the_links.push(e.match(/>\d+</).to_s) }
     regex_the_links.map! do |e|
      if e.blank?
        e = ">0<"
      else
        e = e
      end
    end

    regex_the_links.map! { |e| e.gsub(/[><]/,"") }
    extracted_values = regex_the_links.each_slice(10).to_a
    extracted_values.each do |value|
      overall_high_low << value.first.to_i
    end

    expected = [212, 304, 74, 238, 54, 214, 37, 168, 44, 195]
    assert_equal expected.sort, overall_high_low.sort
  end
end
