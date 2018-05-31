import xml.etree.ElementTree as etree
import sys
import collections

min_len=3
#good_tags = set("NN") #"ADJA ADJD NN".split(" "))
wordCount = collections.Counter()

if len(sys.argv) < 3:
	raise Exception("Please provide 2+ arguments:\n\t1,Number of most frequent words to extract\n\t2+ Files to parse")

limit=int(sys.argv[1])
for xml in sys.argv[2:]:
	tree = etree.parse(xml) 
	words = {}
	correct_tags = set()
	root = tree.getroot()                  
	for corpus in root.findall("{http://www.dspin.de/data/textcorpus}TextCorpus"):
		for lemmas in corpus.findall("{http://www.dspin.de/data/textcorpus}lemmas"):
			for lemma in lemmas.findall("{http://www.dspin.de/data/textcorpus}lemma"):
				words[lemma.attrib["tokenIDs"]] = lemma.text
		for postags in corpus.findall("{http://www.dspin.de/data/textcorpus}POStags"):
			for tag in postags.findall("{http://www.dspin.de/data/textcorpus}tag"):
				if tag.text == "NN": # in good_tags:
					correct_tags.add(tag.attrib["tokenIDs"])
	for key in words:
		if key in correct_tags:
			wordCount[words[key]] += 1

print((" ".join([w.lower() for w,c in wordCount.most_common(limit+100) if len(w) >= min_len and not w[-1]=="."][:limit])).encode('utf-8'))
