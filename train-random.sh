HYPERWORD_PATH="/home/hellrich/hyperwords/omerlevy-hyperwords-688addd64ca2"
WINDOW="5"
SMOOTHING="0.75"
DIM="300"
MIN="100"

function copy {
        #wieso nicht immer von base?
        local target_path=$1
        local from_name=$2
        local to_name=$3
        local source_path=$4

        cp $target_path/${from_name}.words.vocab $source_path/${to_name}.words.vocab
        cp $target_path/${from_name}.contexts.vocab $source_path/${to_name}.contexts.vocab
}


function do_pmi {
        local source_path=$1
        local target_path=$2
        #PMI SVD
        python $HYPERWORD_PATH/hyperwords/pmi2svd.py --dim $DIM $source_path/pmi $target_path/svd_pmi
        copy $target_path pmi svd_pmi $source_path

        echo "finished $target_path pmi"
}



#####################

#glove
for i in 1 2 3
do
        do_pmi pmi_v$i pmi_random_v$i &
done
