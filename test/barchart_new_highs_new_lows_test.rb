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

    def test_convert_fields_to_symbols
      array = ["1-Month", 25]
      expected = [:one_month_low, 25]
      assert_equal expected, @snhnl.convert_field_names_to_symbols(array, "low")
    end

    def test_merge_highs_and_lows
      highs = [:one_month_high, 25]
      lows = [:one_month_low, 10]
      expected = [:one_month_high, 25, :one_month_low, 10]
      assert_equal expected, @snhnl.merge_high_low(highs, lows)
    end

    def test_hash_data_before_insertion
      array = [:one_month_high, 25, :one_month_low, 10]
      expected = { :one_month_high => 25, :one_month_low => 10 }
      assert_equal expected, @snhnl.hash_data_before_insertion(array)
    end

    def test_saved_on_date
      hash = { :one_month_high => 25, :one_month_low => 10 }
      current_time = Time.now.strftime("%Y-%m-%d")
      insert_date = @snhnl.add_datestamp hash
      assert_equal current_time, insert_date
    end

    def test_insertion
      data = { :one_month_high=>706, :three_month_high=>412, :six_month_high=>309,
               :twelve_month_high=>219, :ytd_high=>108, :all_time_high=>65,
               :one_month_low=>139, :three_month_low=>103, :six_month_low=>56,
               :twelve_month_low=>31, :ytd_low=>33, :all_time_low=>5 }

      count = HighLow.count
      @snhnl.add_datestamp data
      @snhnl.insert_data data
      assert_equal count + 1, HighLow.count
      result = HighLow.find_by(one_month_high: 706)
      assert_equal data[:three_month_high], result[:three_month_high]
    end

    def test_complete_conversion_sequence
      highs = @snhnl.extract_table_data_with_class_even @page
      lows = @snhnl.extract_table_data_with_class_odd @page
      high_values = @snhnl.extract_values highs
      low_values = @snhnl.extract_values lows
      high_fields = @snhnl.convert_stringy_numbers_to_int high_values
      low_fields = @snhnl.convert_stringy_numbers_to_int low_values
      highs_integrity = @snhnl.validate_data_integrity high_fields
      lows_integrity = @snhnl.validate_data_integrity low_fields
      convert_highs = @snhnl.convert_field_names_to_symbols(highs_integrity, "high")
      convert_lows = @snhnl.convert_field_names_to_symbols(lows_integrity, "low")
      merged = @snhnl.merge_high_low(convert_highs, convert_lows)
      to_hash = @snhnl.hash_data_before_insertion(merged)
      @snhnl.add_datestamp(to_hash)
    end
  end
end
