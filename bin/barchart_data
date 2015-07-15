#!/usr/bin/env ruby

require "bundler/setup"
require "barchart_data"

require_relative '../lib/barchart_data/alltimehigh'
ath = BarchartData::AllTimeHigh.new
page = ath.parse_url
symbols = ath.strip_symbols(page)
puts symbols
