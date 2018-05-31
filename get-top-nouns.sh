SOURCE="/home/hellrich/historical-emotion/dta/dta_kernkorpus_2016-05-11/full/"
LIMIT=$1
python frequent_lemmata_in_dta.py $LIMIT $SOURCE/*_18{1..9}* $SOURCE/*_1900* $SOURCE/*_180{1..9}* > top-nouns-$LIMIT
