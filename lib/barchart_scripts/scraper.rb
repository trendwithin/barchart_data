require 'active_record'
module BarchartData
  class Scraper
    def extract_symbols_from_page page
      array = page.search('.ds_symbol').map { |e| e.text() }
      array.map! { |elem| elem.split }
    end

    def validate_data_integrity dirty_array
      dirty_array.reduce([]) { |cleaned_array, i|
        cleaned_array << i if i.to_s == i.to_s.upcase
        cleaned_array
      }
    end

    def insert_data arr, sym
    case sym
      when :AllTimeHigh
        arr.each do |s|
          AllTimeHigh.create(symbol: s, saved_on: Time.current)
        end
      end
    end
  end
end
