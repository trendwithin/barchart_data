require 'active_record'
module BarchartData
  class ScrapeNewLows
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

    def insert_data array
      array.each do |elem|
        NewLow.create({ symbol: "#{elem}", saved_on: Time.now.to_date.to_s })
      end
    end
  end
end
