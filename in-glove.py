import numpy as np
import sys

def generate(vocab_file, vectors_file):
    with open(vocab_file, 'r') as f:
        words = [x.rstrip().split(' ')[0] for x in f.readlines()]
    with open(vectors_file, 'r') as f:
        vectors = {}
        for line in f:
            vals = line.rstrip().split(' ')
            vectors[vals[0]] = [float(x) for x in vals[1:]]

    vocab_size = len(words)
    vocab = {w: idx for idx, w in enumerate(words)}
    ivocab = {idx: w for idx, w in enumerate(words)}
    return (vocab, ivocab)


if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("""Provide the following arguments:
            1,vocab_file
            2,vectors_file
            3 words to show neighborhood for (separeated by spaces)""")
        sys.exit(0)
    N = 10;          # number of closest words that will be shown
    vocab, ivocab = generate(sys.argv[1], sys.argv[2])
    for word in open(sys.argv[3],"r").readline().split():
        if not word in vocab:
            print(word, word in vocab)
