require 'barchart_data'
require 'active_record'
require 'mechanize'

module BarchartData
  class NewHigh
    attr_reader :url, :agent

    def initialize
      @url = 'http://www.barchart.com/stocks/high.php'
      @agent = Mechanize.new
    end

     def parse_url
      @agent.get(@url).search("input")
    end

    def strip_symbols(page)
      symbols = page[6].to_s
      strip_symbols = symbols.scan(/[A-Z]+,[^a-z]+[A-Z]/)
      tickers = strip_symbols[0].split(',')
    end

    def insert_symbols(symbols)
      symbols.each do |s|
        :NewHigh.create(symbol: s, saved_on: Time.now.strftime("%m/%d/%Y"))
      end
    end
  end
end
