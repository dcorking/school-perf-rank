require 'minitest/autorun'
require 'debugger'
require File.expand_path('../global-methods', File.dirname(__FILE__))

class TestRank < Minitest::Test
  def test_rank_by_ptac5
    header_row = CSV::Row.new([:schlname, :ptac5],
                              ['Grange Hill', '95%'])
    raw_table = CSV::Table.new([header_row])
    raw_table << ['Hogwarts', '']
    raw_table << ['Saint Trinians', '14%']
    ranked_table = rank_by(:ptac5, raw_table)
    assert_equal 'Grange Hill', ranked_table[-1][:schlname], 'top_school'
    assert_equal 'Saint Trinians', ranked_table[-2][:schlname], 'second best'
    assert_equal 'Hogwarts', ranked_table[-3][:schlname], 'third best'
  end

  def test_rank_by_ttapscp
    header_row = CSV::Row.new([:schlname, :ttapscp],
                              ['Grange Hill', 'FOO'])
    raw_table = CSV::Table.new([header_row])
    raw_table << ['Hogwarts', '225']
    raw_table << ['Saint Trinians', '721']
    ranked_table = rank_by(:ttapscp, raw_table)
    assert_equal 'Saint Trinians', ranked_table[-1][:schlname], 'top_school'
    assert_equal 'Hogwarts', ranked_table[-2][:schlname], 'second best'
    assert_equal 'Grange Hill', ranked_table[-3][:schlname], 'third best'
  end

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
