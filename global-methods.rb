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

# consumes list of numerics, produces a float
def mean(values)
  mu = values[0].to_f
  return mu if values.count == 1
  (2..values.count).each do |n|
    mu = ((n - 1).to_f / n) * (mu + values[n-1] / (n - 1)  )
  end
  mu
end

# consumes list of numerics, produces the population standard
# deviation as a float
def standard_deviation(values)
  mu = mean(values) # mean will usually have already been calculated
  # naive algorithm risks overflow
  variance = sum(values.collect {|x| (x - mu)**2 }) / (values.count)
  Math::sqrt(variance)
end

def sum values
  values.inject(0, :+)
end
