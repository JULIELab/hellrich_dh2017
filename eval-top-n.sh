HYPERWORD_PATH="/home/hellrich/hyperwords/omerlevy-hyperwords-688addd64ca2/hyperwords"
N=$1
LOG="top-log"$N
words=top-nouns-$N

mkdir -p $LOG 
rm $LOG/*

glove="GloVe-1.2/v"
for x in 1 2 3
do
        echo $x >> $LOG/glove
        python closest-glove.py $glove$x/vocab.txt $glove$x/vectors.txt $words >> $LOG/glove
done

for x in 1 2 3
do
        echo $x >> $LOG/sgns
        python $HYPERWORD_PATH/closest-hyper.py --w+c --eig 0 SGNS sgns_v$x/sgns $words >> $LOG/sgns

        echo $x >> $LOG/pmi
        python $HYPERWORD_PATH/closest-hyper.py --w+c --eig 0 SVD pmi_v$x/svd_pmi $words >> $LOG/pmi
done
