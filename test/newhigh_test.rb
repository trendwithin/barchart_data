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


end
