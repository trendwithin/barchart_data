# require './test/minitest_helper'
#
# class TestModel < Minitest::Test
#
#   def setup
#     @ath = AllTimeHigh.new(symbol: 'DEF', saved_on: Time.now.strftime("%m/%d/%Y") )
#     @nh = NewHigh.new(symbol: 'EFG', saved_on: Time.now.strftime("%m/%d/%Y"))
#     @nl = NewLow.new(symbol: 'LMNO', saved_on: Time.now.strftime("%m/%d/%Y"))
#     @atl = NewLow.new(symbol: 'P', saved_on: Time.now.strftime("%m/%d/%Y"))
#   end
#
#   def test_all_time_high_is_valid
#     assert true, @ath.valid?
#   end
#
#   def test_all_time_high_data_model_validation_for_symbol
#     @ath.symbol = '    '
#     refute @ath.valid?
#   end
#
#   def test_all_time_high_data_model_validation_for_saved_on
#     @ath.saved_on = '         '
#     refute @ath.valid?
#   end
#
#   def test_all_time_high_dupe_invalid
#     duplicate_entry = @ath.dup
#     @ath.save
#     refute duplicate_entry.valid?
#   end
#
#   def test_new_high_is_valid
#     assert true, @nh.valid?
#   end
#
#   def test_new_high_data_model_validation_for_symbol
#     @nh.symbol = '      '
#     refute @nh.valid?
#   end
#
#   def test_new_high_data_model_validation_for_saved_on
#     @nh.saved_on = '         '
#     refute @nh.valid?
#   end
#
#   def test_high_low_dupe_invalid
#     duplicate_entry = @nh.dup
#     @nh.save
#     refute duplicate_entry.valid?
#   end
#
#   def test_new_low_is_valid
#     assert true, @nl.valid?
#   end
#
#   def test_new_low_data_model_validation_for_symbol
#     @nl.symbol = '      '
#     refute @nl.valid?
#   end
#
#   def test_new_low_data_model_validation_for_saved_on
#     @nl.saved_on = '         '
#     refute @nl.valid?
#   end
#
#   def test_new_low_dupe_invalid
#     duplicate_entry = @nl.dup
#     @nl.save
#     refute duplicate_entry.valid?
#   end
#
#     def test_all_time_low_is_valid
#     assert true, @atl.valid?
#   end
#
#   def test_all_time_low_data_model_validation_for_symbol
#     @atl.symbol = '      '
#     refute @atl.valid?
#   end
#
#   def test_all_time_low_data_model_validation_for_saved_on
#     @atl.saved_on = '         '
#     refute @atl.valid?
#   end
#
#   def test_all_time_low_dupe_invalid
#     duplicate_entry = @atl.dup
#     @atl.save
#     refute duplicate_entry.valid?
#   end
#
#   def test_high_low_validity
#     now = Time.now.to_date
#     yesterday = now -1
#     hl = HighLow.new(one_month_high: 50, one_month_low: 40,
#                    three_month_high: 30, three_month_low: 20,
#                    six_month_high: 100, six_month_low: 50,
#                    twelve_month_high: 500, twelve_month_low: 400,
#                    ytd_high: 124, ytd_low: 56,
#                    saved_on: yesterday )
#     assert hl.valid?
#   end
# end
