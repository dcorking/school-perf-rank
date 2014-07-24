require 'minitest/autorun'
require 'debugger'
require File.expand_path('../global-methods', File.dirname(__FILE__))

class TestRank < Minitest::Test
  def test_mean
    assert_equal 5, (mean [5])
    assert_in_delta 150.0, (mean [100, 200]), 0.001
    assert_in_delta 200.0, (mean [100.0, 200, 300]), 0.001
  end

  def test_standard_deviation
    assert_in_delta 0.0, (standard_deviation [5]), 0.001
    assert_in_delta 50.0, (standard_deviation [100, 200]), 0.001
    assert_in_delta 81.650, (standard_deviation [100.0, 200, 300]), 0.001
  end
end
