module BarchartData
  class ScrapeNewHighsNewLows
    def extract_table_data_with_class_even page
      array = page.search('.even').map { |e| e.text() }
      array.map! { |elem| elem.split }
    end

    def extract_table_data_with_class_odd page
      array = page.search('.odd').map { |e| e.text() }
      array.map! { |elem| elem.split }
    end

    def extract_values array
      temp = []
      array.each do |elem|
        elem.each_with_index do |elem, index|
          temp << elem if index == 0 || index == 2
        end
      end
      remove_extraneous_elements temp
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
      hash[:saved_on] = Time.now
    end

    def insert_data high_low
      ::HighLow.create(one_month_high: high_low[0], one_month_low: high_low[1],
      three_month_high: high_low[2], three_month_low: high_low[3],
      six_month_high: high_low[4], six_month_low: high_low[5],
      twelve_month_high: high_low[6], twelve_month_low: high_low[7],
      ytd_high: high_low[8], ytd_low: high_low[8],
      saved_on: Time.current )
    end

    private
    def remove_extraneous_elements array
      array.slice!(10,10)
      array
    end
  end
end
