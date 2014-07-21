require 'minitest/autorun'
require 'debugger'
debugger
require 'global_methods'

# Warmup to see if minitest is working!
class TestFixnum < Minitest::Test
  def test_addition
    assert_equal 5, 2+3
  end
end

class TestRank < Minitest::Test
  def test_rank_by_ptac5
    header_row = CSV::Row.new([:schlname, :ptac5],
                              ['Grange Hill', '95%'])
    raw_table = CSV::Table.new([header_row])
    raw_table << ['Hogwarts', '']
    raw_table << ['Saint Trinians', '14%']
    ranked_table = rank_by_ptac5(raw_table)
    assert_equal 'Grange Hill', ranked_table[-1][:schlname], 'top_school'
    assert_equal 'Saint Trinians', ranked_table[-2][:schlname], 'second best'
    assert_equal 'Hogwarts', ranked_table[-3][:schlname], 'third best'
  end
end
