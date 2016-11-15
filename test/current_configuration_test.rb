require './test/minitest_helper'

# Minimal test for verification and validation of set up and helper file
class CurrentConfigurationTest < Minitest::Test
  def setup
    VCR.use_cassette('verify-current-configuration') do
      url = 'https://www.barchart.com/stocks/highs-lows/summary'
      @mechanize = Mechanize.new
      @mechanize.user_agent = 'Mac FireFox'
      @mechanize.get(url)
    end
  end

  def test_status_code
    assert_equal '200', @mechanize.page.code
  end
end
