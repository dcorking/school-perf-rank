## Take care

This is just a demo. Not only is there no warranty, but I don't
maintain it.

See the LICENSE.txt for disclaimer and permission to copy.

## Purpose

To rank the top ten secondary schools in England according to 2
popular measures recorded by national government:
1. Percentage of pupils achieving 5+ A*-C or equivalents
2. Total average (capped) point score per pupil. (The points are allocated by the Government according to GCSE exam grades.)

The program combines the two Government measures to make its ranking
measures in a couple of very arbitrary ways.

## To use

Download some school data from the government website with

    ruby ./download.rb

_The script downloads data for the most recent year, for Bath and
North East Somerset (BANES), and for England_

Rank the BANES data

    ruby -I. ./rank.rb data/800_ks4.csv

Rank the England data

    ruby  -I. ./rank.rb data/england_ks4.csv

Download other data for England from the [Department for Education](http://www.education.gov.uk/schools/performance/2013/download_data.html)

## Sample output
```
ruby  -I./ rank.rb data/england_ks4.csv
Read 5392 rows.
Counted 4125 mainstream rows.
Filtered 2902 rows that are both mainstream and comprehensive.

The top ten schools by our first, crude GCSE scoring method:
1.       Thomas Telford School, Telford
2.       Watford Grammar School for Girls, Watford
3.       Hockerill Anglo-European College, Bishop's Stortford
4.       West Park School, Derby
5.       Dame Alice Owen's School, Potters Bar
6.       Walsall Academy, Walsall
7.       Parkside Academy, Crook
8.       The Priory Academy LSST, Lincoln
9.       Arden, Solihull
10.      King David High School, Liverpool

The top ten schools by our second, deviation-based method of combining GCSE data:
1.       Thomas Telford School, Telford
2.       West Park School, Derby
3.       Parkside Academy, Crook
4.       Arden, Solihull
5.       The Priory Academy LSST, Lincoln
6.       St Andrew's Catholic School, Leatherhead
7.       Hockerill Anglo-European College, Bishop's Stortford
8.       Walsall Academy, Walsall
9.       Toot Hill School, Nottingham
10.      Barr Beacon School, Walsall
```
## Details

The program ranks only mainstream schools that have non-selective admissions policy, whose data it can find in the official tables. At its best, it is only as good as the official tables.

## Bugs and known issues

1. It is really slow, because it does far more calculations than are
   strictly needed. Don't run this on a production server, unless you
   want to be unpopular with production users. There is lots of scope
   for optimization.
2. Ties are ranked arbitrarily
3. The Department for Education only covers England. We don't try to
   get data for Scotland, Wales or Northern Ireland.
