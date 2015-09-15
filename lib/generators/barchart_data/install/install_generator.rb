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
        sleep 2
        time = Time.now.strftime("%Y%m%d%H%M%S")
        template 'newhigh_migration.rb', "db/migrate/#{time}_create_new_highs.rb"
        sleep 1
        time = Time.now.strftime("%Y%m%d%H%M%S")
        template 'newlow_migration.rb', "db/migrate/#{time}_create_new_lows.rb"
        sleep 2
        time = Time.now.strftime("%Y%m%d%H%M%S")
        template 'alltimelow_migration.rb', "db/migrate/#{time}_create_all_time_lows.rb"
        sleep 1
        time = Time.now.strftime("%Y%m%d%H%M%S")
        template 'highlow_migration.rb', "db/migrate/#{time}_create_high_lows.rb"
      end

      def copy_models
        template 'models/all_time_high.rb', 'app/models/all_time_high.rb'
        template 'models/all_time_low.rb', 'app/models/all_time_low.rb'
        template 'models/new_high.rb', 'app/models/new_high.rb'
        template 'models/new_low.rb', 'app/models/new_low.rb'
        template 'models/high_low.rb', 'app/models/high_low.rb'
      end

      def copy_classes
        copy_file "../../../../barchart_data/scraper.rb", 'lib/barchart_data/scraper.rb'
        copy_file "../../../../barchart_data/high_low_scraper.rb", 'lib/barchart_data/high_low_scraper.rb'
        copy_file "../../../../../bin/barchart_data", 'bin/barchart'
      end
    end
  end
end
