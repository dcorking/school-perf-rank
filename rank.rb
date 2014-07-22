#!/usr/bin/env ruby

# Designed to use the Department of Education, England school
# performance tables published in
# http://www.education.gov.uk/schools/performance/2013/download_data.html

# Copyright David Corking, 2014, warranties excluded, see LICENSE file

require 'csv'
require 'global-methods'
require 'debugger'

file_path = ARGV[0]

## Main ##
table = CSV.table file_path
puts "Read #{table.size} rows."
mainstream = mainstream_only(table)
puts "Counted #{mainstream.size} mainstream rows."
main_and_comp = comprehensive_only(mainstream)
puts "Filtered #{main_and_comp.size} rows that are both mainstream and comprehensive."
puts
# Don't need to rank the entire table, but do so for simiplicity.
ptac5 = rank_by(:ptac5, main_and_comp)
top_ptac5 = ptac5[-1]
puts "#{top_ptac5[:schname]} in or near #{top_ptac5[:town]} is the mainstream non-selective school with the highest percentage of pupils achieving 5+ A*-C or equivalents at GCSE"
ttapscp = rank_by(:ttapscp, main_and_comp)
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

# Grab just some columns we need, adding an id, do conversions
main_and_comp = main_and_comp.collect.with_index do |row, i|
   {id: i,
    schname: row[:schname],
    town: row[:town],
    ptac5: row[:ptac5].to_i,
    ttapscp: row[:ttapscp].to_i}
  end

# add a field for a crude average
# gr1 = ( ptac5 + ttapscp  - 300 ) / 2
main_and_comp.each do |school|
  school[:gr1] = (school[:ptac5] + school[:ttapscp] - 300) / 2
  school
  end

main_and_comp = main_and_comp.sort_by { |sch| sch[:gr1] }.reverse
puts "\nThe top ten schools by our first, crude GCSE scoring method:"
main_and_comp.slice(0,10).each_with_index { |school, i|
  puts "#{i+1}.\t #{school[:schname]}, #{school[:town]}"
}


# TODO calculate mean and standard deviations

# TODO calculate gr2
# Do you have an idea how or if PTAC5 and TTAPSCP could usefully be
# weighted into a combined score? Something like this perhaps?
# ( PTAC5 / 2 + (TTAPSCP - 300) / 2)  [ I picked 300 out of thin air - sorry]
# Or an average of the deviation (in s.d.s) of each from the mean score?

# TODO sort by gr2

# require 'pry'
# pry
