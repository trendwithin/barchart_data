require './test/minitest_helper'
require 'fakeweb'

class TestScraper < Minitest::Test
  def setup
    @scraper = ::BarchartData::Scraper.new
    @stream = {
      ath: './test/test_files/athigh.php',
      nh: './test/test_files/newhigh'
    }
  end

  def test_existance
    assert_instance_of BarchartData::Scraper, @scraper
  end

  def test_url_stream
    assert_equal 2, @scraper.urls.size
    assert true, @scraper.urls.has_key?(:all_time_high)
    assert true, @scraper.urls.has_key?(:new_high)
    assert true, @scraper.urls.has_value?('http://www.barchart.com/stocks/athigh.php?_dtp1-0')
    assert true, @scraper.urls.has_value?('http://www.barchart.com/stocks/high.php')
  end

  def test_get_smart
    assert_instance_of Mechanize, @scraper.agent
  end

  def test_fakeweb_using_local_files_returns_nodeset
    FakeWeb.register_uri(:get, @scraper.urls[:all_time_high], :body => @stream[:ath], :content_type => 'text/html')
    noko_node = @scraper.agent.get(@scraper.urls[:all_time_high]).search("input")
    assert_instance_of Nokogiri::XML::NodeSet, noko_node
  end

  def test_symbols_in_nodeset_return_expected_all_time_highs
    FakeWeb.register_uri(:get, @scraper.urls[:all_time_high], :body => @stream[:ath], :content_type => 'text/html')
    noko_node = @scraper.agent.get(@scraper.urls[:all_time_high]).search("input")[6].to_s
    strip_tickers = noko_node.scan(/[A-Z]+,[^a-z]+[A-Z]/)
    symbols = strip_tickers[0].split(',')
    assert_instance_of Array, symbols
    expected = ['AAT', 'LOPE', 'ZMH']
    expected.each do |e|
      assert_includes symbols, e
    end
  end

  def test_symbols_in_nodeset_return_expected_new_highs
    FakeWeb.register_uri(:get, @scraper.urls[:new_high], :body => @stream[:nh], :content_type => 'text/html')
    noko_node = @scraper.agent.get(@scraper.urls[:new_high]).search("input")[6].to_s
    strip_tickers = noko_node.scan(/[A-Z]+,[^a-z]+[A-Z]/)
    symbols = strip_tickers[0].split(',')
    assert_instance_of Array, symbols
    expected = ['AAN', 'POST', 'VRTU']
    expected.each do |e|
      assert_includes symbols, e
    end
  end

  def test_each_key_value_in_urls_returns_expected_stream
    @scraper.urls.each do |sym, url|
      case sym
      when :all_time_high
        assert true, FakeWeb.register_uri(:get, @scraper.urls[sym], :body => @stream[:ath], :content_type => 'text/html')
        assert true, @scraper.agent.get(@scraper.urls[sym]).search("input")[6].to_s.include?('AAT')

      when :new_high
        assert true, FakeWeb.register_uri(:get, @scraper.urls[sym], :body => @stream[:nh], :content_type => 'text/html')
        assert true, @scraper.agent.get(@scraper.urls[sym]).search("input")[6].to_s.include?('VRTU')
      end
    end
  end

  def test_looping_through_urls_and_database_insertion
    @scraper.urls.each do |sym, url|
      case sym
      when :all_time_high
        FakeWeb.register_uri(:get, "#{url}", :body => @stream[:ath], :content_type => 'text/html')
        noko_node = @scraper.agent.get("#{url}").search("input")[6].to_s
        strip_tickers = noko_node.scan(/[A-Z]+,[^a-z]+[A-Z]/)
        symbols = strip_tickers[0].split(',')

        symbols.each do |s|
          AllTimeHigh.create(symbol: s, saved_on: Time.now.to_date.to_s)
        end
        assert AllTimeHigh.find_by(symbol: 'LOPE'), !nil
      when :new_high
        FakeWeb.register_uri(:get, "#{url}", :body => @stream[:nh], :content_type => 'text/html')
        noko_node = @scraper.agent.get("#{url}").search("input")[6].to_s
        strip_tickers = noko_node.scan(/[A-Z]+,[^a-z]+[A-Z]/)
        symbols = strip_tickers[0].split(',')

        symbols.each do |s|
          NewHigh.create(symbol: s, saved_on: Time.now.to_date.to_s)
        end
        assert NewHigh.find_by(symbol: 'POST'), !nil
      end
    end
  end
end
