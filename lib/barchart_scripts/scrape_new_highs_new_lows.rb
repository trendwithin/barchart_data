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

    private
    def remove_extraneous_elements array
      array.slice!(10,10)
      array
    end
  end
end
