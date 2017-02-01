require './test/minitest_helper'
module BarchartData
  class ScrapeNewLowsTest < Minitest::Test
    def setup
      VCR.use_cassette('barchart-52-week-lows') do
        url = 'http://old.barchart.com/stocks/low.php?_dtp1=0'
        @mechanize = BarchartData::BarchartConnection.new
        @page = @mechanize.fetch_page(url)
      end
      @snl = BarchartData::Scraper.new
    end

    def test_200_status_code
      assert_equal 200, @page.code.instance_of?(String) ? @page.code.to_i : @page.code
    end

    def test_extraction_of_new_low_symbols
      array_of_symbols = @snl.extract_symbols_from_page @page
      assert_instance_of Array, array_of_symbols
      assert_equal 54, array_of_symbols.count
    end

    def test_validation_of_symbols
      dirty_array_of_symbols = @snl.extract_symbols_from_page @page
      cleaned_array = @snl.validate_data_integrity dirty_array_of_symbols
      assert_equal 53, cleaned_array.count
    end

    def test_validations_of_symbols_known_data
      dirty = ['Sym', 'BOL', 'Che', 'CK']
      cleaned_array = @snl.validate_data_integrity dirty
      assert_equal 2, cleaned_array.count
    end

    def test_data_insertion
      data = ["NL"]
      @snl.insert_data(data, :NewLow)
      assert_equal data[0], NewLow.last.symbol
    end
  end
end
