require 'barchart_data'
require 'active_record'
require 'mechanize'

module BarchartData
  class HighLowScraper
    attr_reader :url, :agent

    def initialize
      @url = { high_low: 'http://www.barchart.com/stocks/newhilo.php?dwm=d'}
      @agent = Mechanize.new
    end

    def data_extraction
      page = @agent.get(@url[:high_low]).search("div[id='divContent']")
      page.css("td[align='right']").to_a
    end

    def strip_highs_and_lows_from links
      strip_links = []
      regex_the_links = []
      overall_high_low = []

      links.each do |a|
        strip_links.push(a.to_s)
      end

      strip_links.slice!(0..3)
      strip_links.shift(6)
      strip_links.each { |e| regex_the_links.push(e.match(/>\d+</).to_s) }
       regex_the_links.map! do |e|
        if e.blank?
          e = ">0<"
        else
          e = e
        end
      end

      regex_the_links.map! { |e| e.gsub(/[><]/,"") }
      extracted_values = regex_the_links.each_slice(10).to_a
      extracted_values.each do |value|
        overall_high_low << value.first.to_i
      end
      overall_high_low
    end

    def insert_data high_low
      ::HighLow.create(one_month_high: high_low[0], one_month_low: high_low[1],
                     three_month_high: high_low[2], three_month_low: high_low[3],
                     six_month_high: high_low[4], six_month_low: high_low[5],
                     twelve_month_high: high_low[6], twelve_month_low: high_low[7],
                     ytd_high: high_low[8], ytd_low: high_low[8],
                     saved_on: Time.current )
    end
  end
end
