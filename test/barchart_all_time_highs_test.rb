require './test/minitest_helper'

module BarchartData
  class ScraperTest < Minitest::Test
    def setup
      VCR.use_cassette('barchart-all-time-highs') do
        url = 'http://old.barchart.com/stocks/athigh.php?_dtp1=0'
        @mechanize = BarchartData::BarchartConnection.new
        @page = @mechanize.fetch_page(url)
      end
      @sath = BarchartData::Scraper.new
    end

    def test_200_status_code
      assert_equal 200, @page.code.instance_of?(String) ? @page.code.to_i : @page.code
    end

    def test_extraction_of_all_time_high_symbols
      array_of_symbols = @sath.extract_symbols_from_page @page
      assert_instance_of Array, array_of_symbols
      assert_equal 40, array_of_symbols.count
    end

    def test_validation_of_symbols
      dirty_array_of_symbols = @sath.extract_symbols_from_page @page
      cleaned_array = @sath.validate_data_integrity dirty_array_of_symbols
      assert_equal 39, cleaned_array.count
    end

    def test_validations_of_symbols_known_data
      dirty = ['Sym', 'BOL', 'Che', 'CK']
      cleaned_array = @sath.validate_data_integrity dirty
      assert_equal 2, cleaned_array.count
    end

    def test_data_insertion
      data = ["ATH"]
      @sath.insert_data(data, :AllTimeHigh)
      assert_equal data[0], AllTimeHigh.last.symbol
    end
  end
end
