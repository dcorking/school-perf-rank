## Warning

This is just a demo. Not only is there no warranty, but I don't maintain it. By all means use it as an example of one way to use Ruby's standard CSV library to wrangle England's school performance tables.

See the LICENSE.txt for disclaimer and permission to copy.

## Purpose

To list the top ten secondary schools in England according to 2 popular measures recorded by national government:
1. Percentage of pupils achieving 5+ A*-C or equivalents
2. Total average (capped) point score per pupil. (The points are allocated by the Government according to GCSE exam grades.)

## To use

Download some school data from the government website with
    ruby ./download.rb

_The script downloads data for the most recent year, for Bath and North East Somerset (BANES), and for England_

Rank the BANES data
    ruby ./rank.rb data/800_ks4.csv

Rank the England data
    ruby  -I. ./rank.rb data/england_ks4.csv

Download other data for England from the [Department for Education](http://www.education.gov.uk/schools/performance/2013/download_data.html)

## Sample output
```
ruby  -I. ./rank.rb data/england_ks4.csv
Read 5392 rows.
Counted 4125 mainstream rows.
Filtered 2902 rows that are both mainstream and comprehensive./n
Redden Court School in or near Romford is the mainstream non-selective school with the highest percentage of pupils achieving 5+ A*-C or equivalents at GCSE
Redden Court School in or near Romford is the mainstream non-selective school with the highest total average (capped) point score per pupil at GCSE
```
## Details

The program ranks only mainstream schools that have non-selective admissions policy, whose data it can find in the official tables. At its best, it is only as good as the official tables.

## Bugs and known issues

1. It is really slow, because it does far more calculations than are strictly needed. Don't run this on a production server, unless you want to be unpopular with production users. There is lots of scope for optimization.
2. The Department for Education only covers England, so we don't try to get data for Scotland, Wales or Northern Ireland.
