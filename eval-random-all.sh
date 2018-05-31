HYPERWORD_PATH="/home/hellrich/hyperwords/omerlevy-hyperwords-688addd64ca2/hyperwords"

mkdir -p log
for x in 1 3
do
        python $HYPERWORD_PATH/closest-hyper-all.py --w+c --eig 0 SVD pmi_random_v$x/svd_pmi | sort > log/pmi_random_$x &
done
wait
diff log/pmi_random_1 log/pmi_random_3
