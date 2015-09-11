require 'fakeweb'
module TestHelper
  def fakeweb scraper, stream
    FakeWeb.register_uri(:get, scraper.urls[:all_time_high], :body => stream[:ath], :content_type => 'text/html')
    scraper.agent.get(scraper.urls[:all_time_high]).search("input")
  end

  def fakeweb_to_symbols scraper, stream, url_sym, stream_sym
    FakeWeb.register_uri(:get, scraper.urls[url_sym], :body => stream[stream_sym], :content_type => 'text/html')
    noko_node = scraper.agent.get(@scraper.urls[url_sym]).search("input")[6].to_s
    strip_tickers = noko_node.scan(/[A-Z]+,[^a-z]+[A-Z]/)
    symbols = strip_tickers[0].split(',')
  end
end
