import csv

data = []
with open('covidTrain.csv','r') as covidfile:
    lines = csv.reader(covidfile)
    for line in lines:
        data.append(line)

cols = {}
for i, col in enumerate(data[0]):
    cols[col] = i

# q.2.1
tmpList = [x for x in data[1:] if '-' in x[cols['age']]]
for line in tmpList:
    age = line[cols['age']].strip().split('-')
    num = [int(x) for x in age]
    avg = round(sum(num)/2)
    idx = data.index(line)
    data[idx][cols['age']] = str(avg)

# q.2.2
three = ['date_onset_symptoms', 'date_admission_hospital', 'date_confirmation']
for date in three:
    for i in range(1, len(data)):
        dmy = data[i][cols[date]]
        dmy = dmy.split('.')
        mdy = [dmy[1], dmy[0], dmy[-1]]
        mdy = '.'.join(mdy)
        data[i][cols[date]] = mdy
        
# q.2.3
coordinates = ['latitude','longitude']
provs = set([x[cols['province']] for x in data[1:]])
for prov in provs:
    for cod in coordinates:
        tmpList = [x for x in data[1:] if x[cols['province']] == prov]
        num = [x for x in tmpList if x[cols[cod]] != 'NaN']
        val = [float(x[cols[cod]]) for x in num]
        avg = round(sum(val)/len(val), 2)
        
        nan = [x for x in tmpList if x[cols[cod]] == 'NaN']
        for line in nan:
            idx = data.index(line)
            data[idx][cols[cod]] = str(avg)

# q.2.4
provs = set([x[cols['province']] for x in data[1:]])
for prov in provs:
    tmpList = [x for x in data[1:] if x[cols['province']] == prov]
    number = [x for x in tmpList if x[cols['city']] != 'NaN']
    cityList = set([x[cols['city']] for x in number])
    
    city_num = []
    for citi in cityList:
        num = len([x for x in number if x[cols['city']] == citi])
        city_num.append((citi, num))
    city_num.sort(key=lambda x: (-x[-1], x[0]))
    
    
    nan = [x for x in tmpList if x[cols['city']] == 'NaN']
    for line in nan:
        idx = data.index(line)
        data[idx][cols['city']] = city_num[0][0]
        
# q.2.5
provs = set([x[cols['province']] for x in data[1:]])
for prov in provs:
    tmpList = [x for x in data[1:] if x[cols['province']] == prov]
    number = [x for x in tmpList if x[cols['symptoms']] != 'NaN']
    symps = [x[cols['symptoms']] for x in number]
    symps = ';'.join(symps)
    symps = symps.split(';')
    symps = [x.strip() for x in symps]
    
    sympsList = []
    for symp in set(symps):
        num = symps.count(symp)
        sympsList.append((symp, num))
    sympsList.sort(key=lambda x: (-x[-1], x[0]))  

    nan = [x for x in tmpList if x[cols['symptoms']] == 'NaN']
    for line in nan:
        idx = data.index(line)
        data[idx][cols['symptoms']] = sympsList[0][0]
        
with open('covidResult.csv','w') as file:
    myWriter=csv.writer(file)
    for line in data:
        myWriter.writerow(line)

        
