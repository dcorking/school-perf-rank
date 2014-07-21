# lib/global_methods.rb
# Copyright David Corking, 2014, warranties excluded, see LICENSE file

require 'csv'

# Mainstream schools have a RECTYPE of 1
def mainstream_only(table)
  CSV::Table.new table.select{|r| r[:rectype] == 1}
end

# Non selective schools have an ADMPOL of COMP
def comprehensive_only(table)
  CSV::Table.new table.select{|r| r[:admpol] == 'COMP'}
end

# PTAC5 is Percentage of pupils achieving 5+ A*-C or equivalents
def rank_by_ptac5 table
  # this does not need to return the entire table, but it does so for simplicity
  table.sort_by{ |r| r[:ptac5].to_i }
end

# TTAPSCP is Total average (capped) point score per pupil
def rank_by_ttapscp table
  table.sort_by{ |r| r[:ttapscp].to_i }
end
