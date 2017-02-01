require 'active_record'
module BarchartData
  class ScrapeNewHighsNewLows
    def extract_table_data_with_class_even page
      array = page.search('.even').map { |e| e.text() }
      array = prune_array_data array
      array.map! { |elem| elem.split }
    end

    def extract_table_data_with_class_odd page
      array = page.search('.odd').map { |e| e.text() }
      array = prune_array_data array
      array.map! { |elem| elem.split }
    end

    def prune_array_data arr
      ten = arr[10]
      arr.slice!(5..15)
      arr << ten
    end

    def extract_values array
      temp = []
      array.each do |elem|
        elem.each_with_index do |e, i|
          temp << e if i == 0 || i == 2
        end
      end
      temp
      # remove_extraneous_elements temp
    end

    def convert_stringy_numbers_to_int array
      array.map! { |elem| elem !~ /\D/ ? elem.to_i : elem }
      array
    end

    def validate_data_integrity array
      return false unless array.partition { |v| v.is_a? String }[0].count == 6
      return false unless array.partition { |v| v.is_a? Integer }[0].count == 6
      array
    end

    def convert_field_names_to_symbols array, arg
      keyed_array = []
      hash = { "1-Month" => :"one_month_#{arg}", "3-Month" => :"three_month_#{arg}",
               "6-Month" => :"six_month_#{arg}", "52-Week" => :"twelve_month_#{arg}",
               "YTD" => :"ytd_#{arg}", "All-Time" => :"all_time_#{arg}" }

      array.each { |elem| hash.include?(elem) ? keyed_array << hash[elem] : keyed_array << elem }
      keyed_array
    end

    def merge_high_low highs, lows
      highs + lows
    end

    def hash_data_before_insertion array
      array.each_slice(2).to_h
    end

    def add_datestamp hash
      hash[:saved_on] = Time.now.strftime("%Y-%m-%d")
    end

    def insert_data high_low
      HighLow.create(high_low)
    end

    private
    def remove_extraneous_elements array
      array.slice!(10,10)
      array
    end
  end
end
