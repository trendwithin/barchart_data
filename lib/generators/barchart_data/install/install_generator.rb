require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'


module BarchartData
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_migrations
        time = Time.now.strftime("%Y%m%d%H%M%S")
        template "alltimehigh_migration.rb", "db/migrate/#{time}_create_all_time_highs.rb"
        template 'newhigh_migration.rb', "db/migrate/#{time}_create_new_highs.rb"
        template 'newlow_migration.rb', "db/migrate/#{time}_create_new_lows.rb"
        template 'alltimelow_migration.rb', "db/migrate/#{time}_create_all_time_lows.rb"
        template 'highlow_migration.rb', "db/migrate/#{time}_create_high_lows.rb"
      end

      def copy_classes
        copy_file "../../../../barchart_data/scraper.rb", 'lib/barchart_data/scraper.rb'
        copy_file "../../../../barchart_data/high_low_scraper.rb", 'lib/barchart_data/high_low_scraper.rb'
        copy_file "../../../../../bin/barchart_data", 'bin/barchart'
      end
    end
  end
end
