import csv
from collections import defaultdict

# q.1.1
data = []
with open('input_files/pokemon/pokemonTrain.csv','r') as pokemonfile:
    lines = csv.reader(pokemonfile)
    for line in lines:
        data.append(line)
        
cols = {}
names = data[0]
for i, col in enumerate(data[0]):
    cols[col] = i
    
num_of_pokemon = len(data[1:])
fire_type = [x for x in data[1:] if x[cols['type']] == 'fire']
fire_type_40 = [x for x in fire_type if float(x[cols['level']]) >= 40]

with open('pokemon1.txt', 'w') as f:
    f.write('Percentage of fire type Pokemons at or above level 40 = {}%'.format(round(len(fire_type_40) / num_of_pokemon*100)))


# q.1.2
def get_type_weak():
    weak_dict = {}
    types = set([x[cols['type']] for x in data[1:]])
    weakness = set([x[cols['weakness']] for x in data[1:]])
    
    for typ in types:
        tmp_typ = [x for x in data[1:] if x[cols['type']] == typ]
        weak = []
        for wk in weakness:
            tmp_wk = [x for x in tmp_typ if x[cols['weakness']] == wk]
            weak.append((wk, len(tmp_wk)))
        weak.sort(key=lambda x: (-x[-1], x[0]))
        weak_dict[typ] = weak[0][0]
        
    return weak_dict

weak_dict = get_type_weak()

def weak_type(wk):
    for k, v in weak_dict.items():
        if v == wk:
            return k
        
tmp_typ = [x for x in data[1:] if x[cols['type']] == 'NaN']
nan_idx = [data.index(x) for x in tmp_typ]

for i in nan_idx:
    tp = weak_type(data[i][cols['weakness']])
    data[i][cols['type']] = tp

# q.1.3
three = ['atk', 'def', 'hp']
average_above_40 = {}
average_40 = {}

for tri in three:
    tmp = [x for x in data[1:] if x[cols[tri]] != 'NaN']
    tmp_hi = [x for x in tmp if float(x[cols['level']]) > 40]
    tmp_hi = [float(x[cols[tri]]) for x in tmp_hi]
    average_above_40[tri] = round(sum(tmp_hi) / len(tmp_hi),1)
    
    tmp_lo = [x for x in tmp if float(x[cols['level']]) <= 40]
    tmp_lo = [float(x[cols[tri]]) for x in tmp_lo]
    average_40[tri] = round(sum(tmp_lo) / len(tmp_lo),1)

for tri in three:
    tmp = [x for x in data[1:] if x[cols[tri]] == 'NaN']
    tmp_idx = [data.index(x) for x in tmp]
    for idx in tmp_idx:
        data[idx][cols[tri]] = average_above_40[tri] if float(data[idx][cols['level']]) > 40 else average_40[tri]

with open('pokemonResult.csv','w') as file:
    myWriter = csv.writer(file)
    for line in data:
        myWriter.writerow(line)

            
# q.1.4
types = list(set([x[cols['type']] for x in data[1:]]))
types.sort()
personality_dict = defaultdict(list)

for typ in types:
    tmpList = [x for x in data[1:] if x[cols['type']] == typ]
    for pkm in tmpList:
        personality_dict[typ].append(pkm[cols['personality']])
new_personality_dict = {}

for k,v in personality_dict.items():
    v = list(set(v))
    v.sort()
    new_personality_dict[k] = v
               
with open('pokemon4.txt', 'w') as f:
    f.write('Pokemon type to personality mapping:' + '\n')
    for k, v in new_personality_dict.items():
        f.write(k +': '+ ', '.join(v) + '\n')

# q.1.5
tmpList = [x for x in data[1:] if float(x[cols['stage']]) == 3.0]
tmpList = [float(x[cols['hp']]) for x in tmpList]
with open('pokemon5.txt', 'w') as f:
    f.write('Average hit point for Pokemons of stage 3.0 = {}'.format(round(sum(tmpList) / len(tmpList))))
