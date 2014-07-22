#!/usr/bin/env ruby

# Designed to use the Department of Education, England school
# performance tables published in
# http://www.education.gov.uk/schools/performance/2013/download_data.html

# Copyright David Corking, 2014, warranties excluded, see LICENSE file

require 'csv'
require 'global-methods'
require 'debugger'

file_path = ARGV[0]
debugger
## Main ##
table = CSV.table file_path
puts "Read #{table.size} rows."
mainstream = mainstream_only(table)
puts "Counted #{mainstream.size} mainstream rows."
main_and_comp = comprehensive_only(mainstream)
puts "Filtered #{main_and_comp.size} rows that are both mainstream and comprehensive."
puts
# Don't need to rank the entire table, but do so for simiplicity.
ptac5 = rank_by_ptac5(main_and_comp)
top_ptac5 = ptac5[-1]
puts "#{top_ptac5[:schname]} in or near #{top_ptac5[:town]} is the mainstream non-selective school with the highest percentage of pupils achieving 5+ A*-C or equivalents at GCSE"
ttapscp = rank_by_ttapscp(main_and_comp)
top_ttapscp = ttapscp[-1]
puts "#{top_ttapscp[:schname]} in or near #{top_ttapscp[:town]} is the mainstream non-selective school with the highest total average (capped) point score per pupil at GCSE"
puts
puts "The top ten schools by five GCSE grades C or above are:"
(1..10).each { |i|
  puts "#{i}.\t #{ptac5[-i][:schname]}, #{ptac5[-i][:town]}"
}
puts
puts "The top ten schools by GCSE point scores are:"
(1..10).each { |i|
  puts "#{i}.\t #{ttapscp[-i][:schname]}, #{ttapscp[-i][:town]}"
}
