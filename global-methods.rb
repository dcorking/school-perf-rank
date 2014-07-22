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
# TTAPSCP is Total average (capped) point score per pupil
def rank_by(field, table)
  table.sort_by{ |r| r[field].to_i }
end
