require './test/minitest_helper'

module BarchartData
  class ScrapeNewHighsNewLowsTest < Minitest::Test
    def setup
      VCR.use_cassette('barchart-new-highs-new-lows') do
        url = 'https://www.barchart.com/stocks/highs-lows/summary'
        @mechanize = BarchartData::BarchartConnection.new
        @page = @mechanize.fetch_page(url)
      end
      @snhnl = BarchartData::ScrapeNewHighsNewLows.new
    end

    def test_200_status_code
      assert_equal 200, @page.code.instance_of?(String) ? @page.code.to_i : @page.code
    end

    def test_extract_td_attribute_with_even_class_from_page
      expectation = @snhnl.extract_table_data_with_class_even @page
      assert_instance_of Array, expectation
      assert_equal 11, expectation.size
    end

    def test_extract_td_attribute_with_odd_class_from_page
      expectation = @snhnl.extract_table_data_with_class_odd @page
      assert_instance_of Array, expectation
      assert_equal 11, expectation.size
    end

    def test_extract_new_highs
      fields = %w{ 1-Month 3-Month 6-Month 52-Week YTD All-Time }
      evens = @snhnl.extract_table_data_with_class_even @page
      temp = @snhnl.extract_values evens
      fields.each do |elem|
        assert_equal true, temp.include?(elem)
      end
      assert_equal 12, temp.size
    end

    def test_extract_new_lows
      fields = %w{ 1-Month 3-Month 6-Month 52-Week YTD All-Time }
      odds = @snhnl.extract_table_data_with_class_odd @page
      temp = @snhnl.extract_values odds
      fields.each do |elem|
        assert_equal true, temp.include?(elem)
      end
      assert_equal 12, temp.size
    end

    def test_converting_string_numbers_to_int
      array = ["1-Month", "150", "6-Month", "100"]
      temp = @snhnl.convert_stringy_numbers_to_int array
      assert_equal true, temp.include?(150)
      assert_equal true, temp.include?(100)
      refute_equal true, temp.include?("150")
      refute_equal true, temp.include?("100")
    end

    def test_data_integrity
      evens = @snhnl.extract_table_data_with_class_even @page
      temp = @snhnl.extract_values evens
      converted = @snhnl.convert_stringy_numbers_to_int temp
      validated = @snhnl.validate_data_integrity converted
      assert_equal 12, validated.size
      refute_equal true, validated.include?(nil)
      refute_equal true, validated.include?('')
    end

    def test_invalid_data
      array = ['', nil, '50', nil, '109']
      validated = @snhnl.validate_data_integrity array
      assert_equal false, validated
    end
  end
end
