# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'barchart_data/version'

Gem::Specification.new do |spec|
  spec.name          = "barchart_data"
  spec.version       = BarchartData::VERSION
  spec.authors       = ["Michael Becco"]
  spec.email         = ["e4e6d4d5@gmail.com"]

  spec.summary       = %q{Scrape Data From BarCharts.com and persist in database}
  spec.description   = %q{Gem Purpose to extract data for all-time-highs, new-highs, new-lows and store for queries}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'mechanize', '~> 2.7.3'
  spec.add_development_dependency 'nokogiri', '~> 1.6.6.2'
  spec.add_development_dependency 'fakeweb', '~> 1.3.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3.10'
  spec.add_dependency             'activerecord', '~> 4.2.2'
end
