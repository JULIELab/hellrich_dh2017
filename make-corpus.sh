SOURCE="/home/hellrich/historical-emotion/dta/dta_kernkorpus_2016-05-11_lemma"

for f in $SOURCE/*_18{1..9}? $SOURCE/*_1900 $SOURCE/*_180{1..9} #19th centruy
do
	tr '\n' ' ' < $f | sed "s/[[:upper:]]*/\L&/g;s/[^[:alnum:]]*[ \t\n\r][^[:alnum:]]*/ /g;s/[^a-z0-9]*$/ /g;s/  */ /g;/^\s*$/d" >> corpus
done