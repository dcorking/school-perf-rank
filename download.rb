# hackish, no error checking

# import Bath and North East Somerset
system("cd data; wget -c http://www.education.gov.uk/schools/performance/download/csv/800_ks4.csv")
# import the table for all of England KS4
system("cd data; wget -c http://www.education.gov.uk/schools/performance/download/csv/england_ks4.csv")
