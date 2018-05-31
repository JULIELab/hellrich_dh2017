import sys


def intersection(sequences, n):
    if len(sequences) < 2:
        raise Exception("Need multiple sequences for comparisson")
    inter = set(sequences[0][:n])
    for s in sequences[1:]:
        inter = inter.intersection(s[:n])
    return inter


def parse(filename):
    result = {}
    digit = None
    with open(filename) as f:
        for line in f:
            if line.strip().isdigit():
                digit = line.strip()
                result[digit] = {}
            elif " : " in line:
                word = line.split(" : ")[0].strip()
                words = [w.strip()
                         for w in line.split(" : ")[1].strip().split()]
                result[digit][word] = words
    return result


def main():
    wordlists = parse(sys.argv[1])
    maximum = float(sys.argv[2])
    n_sums = {}
    for word in wordlists["1"]:
        for n in range(1, 11):
            words = [wordlists[index][word] for index in wordlists]
            if not n in n_sums:
                n_sums[n] = 0
            n_sums[n] += len(intersection(words, n))
    for n in n_sums:
        print(n, n_sums[n], n_sums[n] / n, (n_sums[n] / n) / maximum)


if __name__ == '__main__':
    main()
