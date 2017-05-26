module BarchartData
  class BarchartLogger

    def directory_exist?
      File.directory?('log')
    end

    def file_exist?
      File.exist?('log/barchart_logger.log')
    end

    def create_log_file
      unless file_exist?
        File.new('log/barchart_logger.log')
      end
      file_exist?
    end

    def error_logging message
      if file_exist?
        begin
          File.open('log/barchart_logger.log', 'w') { |file| file.write "#{message}"}
        rescue IOError => io
          # Do Something
        end
      else
        $>
      end
    end
  end
end
