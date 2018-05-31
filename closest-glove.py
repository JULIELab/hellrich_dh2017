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

    vector_dim = len(vectors[ivocab[0]])
    W = np.zeros((vocab_size, vector_dim))
    for word, v in vectors.items():
        if word == '<unk>':
            continue
        W[vocab[word], :] = v

    # normalize each word vector to unit variance
    W_norm = np.zeros(W.shape)
    d = (np.sum(W ** 2, 1) ** (0.5))
    W_norm = (W.T / d).T
    return (W_norm, vocab, ivocab)


def distance(W, vocab, ivocab, word):
    if word not in vocab:
        #print('Word: %s  Out of dictionary!\n' % word)
        return

    vec_result = W[vocab[word], :] 
    
    vec_norm = np.zeros(vec_result.shape)
    d = (np.sum(vec_result ** 2,) ** (0.5))
    vec_norm = (vec_result.T / d).T

    dist = np.dot(W, vec_norm.T)
    dist[vocab[word]] = -np.Inf

    a = np.argsort(-dist)[:N]

    print(word+" : "+" ".join([ivocab[x] for x in a]))


if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("""Provide the following arguments:
            1,vocab_file
            2,vectors_file
            3,file with words to show neighborhood for (separeated by spaces)""")
        sys.exit(0)
    N = 10;          # number of closest words that will be shown
    W, vocab, ivocab = generate(sys.argv[1], sys.argv[2])
    for word in open(sys.argv[3],"r").readline().split():
        distance(W, vocab, ivocab, word)
