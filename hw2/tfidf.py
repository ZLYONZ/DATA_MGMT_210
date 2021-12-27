import re

with open('tfidf_docs.txt') as f:
    files = f.read()
files = files.split('\n')
files = [x for x in files if x]

# q 3.1.1
f = open(files[1])
text = f.read()
f.close()

text = re.sub('\n', ' ', text)
text = re.sub('http.*? ', '', text)

def rmvComma(line):
    ptns = re.findall('\d,\d', line)
    for ptn in ptns:
        line = line.replace(ptn, ptn.replace(',', ''))
    return line
text = rmvComma(text)

# punctuation = r'-!#$%&"()*+,./:;<=>?@[\]^`{|}~\''
punctuation = r'-!#$%&"()—*+,./:°;“”<=>’?@[\]^`{|}~\''  
def rmvPunc(text):
    text = re.sub(r'[{}]+'.format(punctuation),'',text)
    return text.strip()
text = rmvPunc(text)

def rmvSpace(text):
    text = re.sub(' +', ' ', text)
    return text
text = rmvSpace(text)
text = text.lower()

# q 3.1.2
with open('stopwords.txt') as f:
    stopwords = f.read()

stopwords = stopwords.strip().split('\n')

text = text.split(' ')
text = [x for x in text if not x in stopwords]
text = ' '.join(text)

# q 3.1.3
text = text.split()
def stemLem(word):
    if word.endswith('ly'):
        return word[:-2]
    if word.endswith('ment'):
        return word[:-4]
    if word.endswith('ing'):
        return word[:-3]
    return word

text = [stemLem(x) for x in text]
text = ' '.join(text)

with open('preproc_' + files[1], 'w') as f:
    f.write(text)

# q 3.2
texts = []
for file in files:
    with open(file) as f:
        text = f.read()
        texts.append(text)

def prePro(text):
    file = files[texts.index(text)]
    text = re.sub('\n', ' ', text)
    text = re.sub('http.*? ', '', text)
    text = rmvComma(text)
    text = rmvPunc(text)
    text = rmvSpace(text)
    text = text.lower()
    
    text = text.split(' ')
    text = [x for x in text if not x in stopwords]
    totol_num_of_words = len(text)
    text = [stemLem(x) for x in text]
    text = ' '.join(text)
    
    with open('preproc_' + file, 'w') as f:
        f.write(text)

    return text, totol_num_of_words

tf_dict = {}
terms = []
for i in range(len(files)):
    text = texts[i]
    text, total_num_of_words = prePro(text)
    text = text.split(' ')
    total_num_of_words = len(text)
    
    keys = set(text)
    terms.extend(list(keys))
    tf_dict[files[i]] = {}
    
    for key in keys:
        num = text.count(key)
        tf_dict[files[i]][key] = num / total_num_of_words

terms = list(set(terms))
idf_dict = {}
total_num_of_docs = len(files)

for term in terms:
    num = sum([term in x.keys() for x in tf_dict.values()])
    if num:
        idf = total_num_of_docs / num
    else:
        idf = 0
    idf_dict[term] = idf
    
# Also, add 1 to the IDF score so that the TF-IDF score is non-zero.
# for k, v in idf_dict.items():
#     idf_dict[k] = v + 1
#     print(k, '-->', v)

# Calculate TF-IDF score
tf_idf_dict = {}
for file, tfs in tf_dict.items():
    tf_idf_dict[file] = {}
    for k, v in tfs.items():
        tf_idf = round(v * idf_dict[k], 2)
        tf_idf_dict[file][k] = tf_idf

for file, tf_idf in tf_idf_dict.items():
    tmp = sorted(tf_idf.items(), key=lambda item:item[1], reverse=True)
    print(tmp)
    with open('tfidf_' + file, 'w') as f:
        f.write(str(tmp[:5]))
