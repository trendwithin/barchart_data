require 'mechanize'

module BarchartData
  class BarchartConnection
    attr_accessor :mechanize

    def initialize
      @mechanize = Mechanize.new
      @mechanize.user_agent = 'Mac FireFox'
    end

    def fetch_page(url)
      @mechanize.get(url)
    end
  end
end
