require './test/minitest_helper'

class TestBarchartData < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::BarchartData::VERSION
  end

  def test_it_does_something_useful
    assert_instance_of Module, ::BarchartData
  end
end
