require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'


module BarchartData
  module Generators
    class BarchartDataGenerator < Rails::Generators::Base
      source_root File.expand_path('..', __FILE__)

      def copy_schema
        copy_file '/test/support/schema.rb', 'db/migrate/schema.rb'
      end
    end
  end
end
