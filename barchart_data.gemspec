# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'barchart_data/version'

Gem::Specification.new do |spec|
  spec.name          = "barchart_data"
  spec.version       = BarchartData::VERSION
  spec.authors       = ["Michael Becco"]
  spec.email         = ["e4e6d4d5@gmail.com"]
  spec.licenses      = ['MIT']
  spec.summary       = %q{Scrape Data From BarCharts.com and persist in database}
  spec.description   = %q{Extract data for all-time-highs, new-highs, new-lows and store.  Generator for schema
                          and Ruby scripts for integration with Rails. }
  spec.homepage      = "https://github.com/trendwithin/barchart_data"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12.4"
  spec.add_development_dependency "rake", "~> 11.3.0"
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.3'
  spec.add_development_dependency 'sqlite3', '~> 1.3.11'
  spec.add_development_dependency 'minitest-coverage', '~> 1.0.0.b1'
  spec.add_development_dependency 'byebug', '~> 9.0', '>= 9.0.6'
  spec.add_development_dependency 'webmock', '~> 2.0', '>= 2.0.3'
  spec.add_dependency             'activerecord', '~> 5.0.0.1'
  spec.add_dependency             'mechanize', '~> 2.7.5'
  spec.add_dependency             'nokogiri', '~> 1.6.8.1'
end
