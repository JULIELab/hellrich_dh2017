HYPERWORD_PATH="/home/hellrich/hyperwords/omerlevy-hyperwords-688addd64ca2"
WINDOW="5"
SMOOTHING="0.75"
DIM="300"
MIN="100"

function glove {
  cd GloVe-1.2
  for x in 1 2 3
  do
        mkdir -p v$x
        ./demo.sh
        mv vectors.txt vocab.txt v$x
  done
}

function copy {
        #wieso nicht immer von base?
        local target_path=$1
        local from_name=$2
        local to_name=$3

        cp $target_path/${from_name}.words.vocab $target_path/${to_name}.words.vocab
        cp $target_path/${from_name}.contexts.vocab $target_path/${to_name}.contexts.vocab
}

function do_chi {
        local source_path=$1
        local target_path=$2
        prepare $source_path $target_path
        #CHI
        python $HYPERWORD_PATH/hyperwords/counts2chi_efficient_3.py --cds $SMOOTHING $target_path/counts $target_path/chi
        #CHI SVD
        python $HYPERWORD_PATH/hyperwords/chi2svd.py --dim $DIM $target_path/chi $target_path/svd_chi
        copy $target_path chi svd_chi

        echo "finished $target_path chi"
}

function do_pmi {
        local source_path=$1
        local target_path=$2
        prepare $source_path $target_path
        #PMI
        python $HYPERWORD_PATH/hyperwords/counts2pmi.py --cds $SMOOTHING $target_path/counts $target_path/pmi
        #PMI SVD
        python $HYPERWORD_PATH/hyperwords/pmi2svd.py --dim $DIM $target_path/pmi $target_path/svd_pmi
        copy $target_path pmi svd_pmi

        echo "finished $target_path pmi"
}

function do_sgns {
        local source_path=$1
        local target_path=$2
        prepare $source_path $target_path
        #SGNS
        $HYPERWORD_PATH/word2vecf/word2vecf -train $target_path/pairs -pow $SMOOTHING -cvocab $target_path/counts.contexts.vocab -wvocab $target_path/counts.words.vocab -dumpcv $target_path/sgns.contexts -output $target_path/sgns.words -threads 10 -negative 5 -size $DIM
        python $HYPERWORD_PATH/hyperwords/text2numpy.py $target_path/sgns.words
        rm $target_path/sgns.words
        python $HYPERWORD_PATH/hyperwords/text2numpy.py $target_path/sgns.contexts
        rm $target_path/sgns.contexts

        echo "finished $target_path sgns"
}

function prepare {
        local source_path=$1
        local target_path=$2
        mkdir -p $target_path
        python $HYPERWORD_PATH/hyperwords/corpus2pairs.py --win $WINDOW $source_path --thr $MIN > $target_path/pairs
        $HYPERWORD_PATH/scripts/pairs2counts.sh $target_path/pairs > $target_path/counts
        python $HYPERWORD_PATH/hyperwords/counts2vocab.py $target_path/counts
}


#####################

#glove
for i in 1 2 3
do
(
        do_chi /home/hellrich/dh2017/corpus chi_v$i
        do_sgns /home/hellrich/dh2017/corpus sgns_v$i
        do_pmi /home/hellrich/dh2017/corpus pmi_v$i
) & 
done
