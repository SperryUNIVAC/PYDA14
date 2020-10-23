import requests
import json


def max_rate():
    full_data = requests.get('https://www.cbr-xml-daily.ru/daily_json.js').json()  
# это я добавил чисто для себя, поучится записывать вытащенные значения в файл
# заодно посмотрел на структуру того, чего вытащил
    with open('data.txt', 'w') as f:
        json.dump(full_data, f, ensure_ascii=False)
    datadict = self.datadict['Valute']
    max_rate_code = max(datadict.items(), key=lambda x: x[1]['Value'] / x[1]['Nominal'])[1]['Name']
    print(max_rate_code) 


