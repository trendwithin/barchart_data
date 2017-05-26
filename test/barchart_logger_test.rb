require './test/minitest_helper'

module BarchartData
  class BarchartLoggerTest < MiniTest::Test
    def setup
      @logger = BarchartData::BarchartLogger.new
    end

    def test_for_existance_of_file
      assert_equal false, File.directory?('log')
    end

    def test_stub_existance_of_directory
      BarchartData::BarchartLogger.new.stub(:directory_exist?, true) do
        @logger.directory_exist?
      end
    end

    def test_mock_existance_of_directory
      mock = Minitest::Mock.new
      mock.expect :directory_exist?, true
      BarchartData::BarchartLogger.new.stub :directory_exist?, mock do
        assert_equal true, mock.directory_exist?
      end
      assert_mock mock
    end

    def test_stub_file_exist
      BarchartData::BarchartLogger.new.stub(:file_exist?, true) do
        # assert_equal true, File.directory?('log')
        @logger.file_exist?
      end
    end

    def test_mock_existance_of_file
      mock = Minitest::Mock.new
      mock.expect :file_exist?, true
      BarchartData::BarchartLogger.new.stub :file_exist?, mock do
        assert_equal true, mock.file_exist?
      end
      assert_mock mock
    end

    def test_create_log_file_if_one_does_not_exist
      mock = Minitest::Mock.new
      file_mock = Minitest::Mock.new
      mock.expect :file_exist?, false
      BarchartData::BarchartLogger.new.stub :file_exist?, mock do
        assert_equal false, mock.file_exist?
      end
      assert_mock mock
      file_mock.expect :create_log_file, true
      BarchartData::BarchartLogger.new.stub :create_log_file, file_mock do
        assert_equal true, file_mock.create_log_file
      end
      assert_mock file_mock
    end
  end
end
