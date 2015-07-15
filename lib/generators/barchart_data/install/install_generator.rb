require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'


module BarchartData
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_schema
        time = Time.now.strftime("%Y%m%d%H%M%S")
        template "schema.rb", "db/migrate/#{time}_create_all_time_highs.rb"
        copy_file "../../../../barchart_data/alltimehigh.rb", 'lib/barchart_data/alltimehigh.rb'
        copy_file "../../../../../bin/barchart_data", 'bin/barchart'
      end
    end
  end
end
