require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'


module BarchartData
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_schema
        template "schema.rb", "db/migrate/schema.rb"
      end
    end
  end
end
