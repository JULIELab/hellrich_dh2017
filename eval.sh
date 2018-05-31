HYPERWORD_PATH="/home/hellrich/hyperwords/omerlevy-hyperwords-688addd64ca2/hyperwords"

mkdir -p log

glove="GloVe-1.2/v"
rm log/glove
for x in 1 2 3
do
        echo $x >> log/glove
        python closest-glove.py $glove$x/vocab.txt $glove$x/vectors.txt frau gott herr herz liebe mann mutter nacht tag wein >> log/glove
done

rm log/{sgns,chi,pmi}
for x in 1 2 3
do
        echo $x >> log/sgns
        python $HYPERWORD_PATH/closest-hyper.py --w+c --eig 0 SGNS sgns_v$x/sgns frau gott herr herz liebe mann mutter nacht tag wein >> log/sgns

        echo $x >> log/chi
        python $HYPERWORD_PATH/closest-hyper.py --w+c --eig 0 SVD chi_v$x/svd_chi frau gott herr herz liebe mann mutter nacht tag wein >> log/chi

        echo $x >> log/pmi
        python $HYPERWORD_PATH/closest-hyper.py --w+c --eig 0 SVD pmi_v$x/svd_pmi frau gott herr herz liebe mann mutter nacht tag wein >> log/pmi
done
