HYPERWORD_PATH="/home/hellrich/hyperwords/omerlevy-hyperwords-688addd64ca2/hyperwords"

mkdir -p log
rm -f log/pmi_random
for x in 1 2 3
do
        echo $x >> log/pmi_random
        python $HYPERWORD_PATH/closest-hyper.py --w+c --eig 0 SVD pmi_random_v$x/svd_pmi frau gott herr herz liebe mann mutter nacht tag wein >> log/pmi_random
done
