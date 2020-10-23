import requests
import json

class Rate:
    def __init__(self):
        self.datadict = requests.get('https://www.cbr-xml-daily.ru/daily_json.js').json()

    def max_rate(self):
        datadict = self.datadict['Valute']
        max_rate_code = max(datadict.items(), key=lambda x: x[1]['Value'] / x[1]['Nominal'])[1]['Name']
        print(max_rate_code)

    def rate(self, key, diff = 'False'):
        rate = self.datadict['Valute'][key]['Value']
        previous = self.datadict['Valute'][key]['Previous']
        if diff == 'False':
            print(rate, ' за ', self.datadict['Valute'][key]['Nominal'], ' шт')
        else:
            print(round((rate-previous), 5))

# всякие разные основные валюты + Белорусь и Украина, что еще русскому человеку нужно!
    def gbp_rate(self, diff = 'False'):
        rate = self.datadict['Valute']['GBP']['Value']
        previous = self.datadict['Valute']['GBP']['Previous']
        if diff == 'False':
            print(rate, ' за ', self.datadict['Valute']['GBP']['Nominal'], ' шт')
        else:
            print(round((rate-previous), 5))

    def usd_rate(self, diff = 'False'):
        rate = self.datadict['Valute']['USD']['Value']
        previous = self.datadict['Valute']['USD']['Previous']
        if diff == 'False':
            print(rate, ' за ', self.datadict['Valute']['USD']['Nominal'], ' шт')
        else:
            print(round((rate-previous), 5))

    def eur_rate(self, diff = 'False'):
        rate = self.datadict['Valute']['EUR']['Value']
        previous = self.datadict['Valute']['EUR']['Previous']
        if diff == 'False':
            print(rate, ' за ', self.datadict['Valute']['EUR']['Nominal'], ' шт')
        else:
            print(round((rate-previous), 5))

    def chy_rate(self, diff = 'False'):
        rate = self.datadict['Valute']['CNY']['Value']
        previous = self.datadict['Valute']['CNY']['Previous']
        if diff == 'False':
            print(rate, ' за ', self.datadict['Valute']['CNY']['Nominal'], ' шт')
        else:
            print(round((rate-previous), 5))

    def chf_rate(self, diff = 'False'):
        rate = self.datadict['Valute']['CHF']['Value']
        previous = self.datadict['Valute']['CHF']['Previous']
        if diff == 'False':
            print(rate, ' за ', self.datadict['Valute']['CHF']['Nominal'], ' шт')
        else:
            print(round((rate-previous), 5))

    def jpy_rate(self, diff = 'False'):
        rate = self.datadict['Valute']['JPY']['Value']
        previous = self.datadict['Valute']['JPY']['Previous']
        if diff == 'False':
            print(rate, ' за ', self.datadict['Valute']['JPY']['Nominal'], ' шт')
        else:
            print(round((rate-previous), 5))

    def byn_rate(self, diff = 'False'):
        rate = self.datadict['Valute']['BYN']['Value']
        previous = self.datadict['Valute']['BYN']['Previous']
        if diff == 'False':
            print(rate, ' за ', self.datadict['Valute']['BYN']['Nominal'], ' шт')
        else:
            print(round((rate-previous), 5))

    def uah_rate(self, diff = 'False'):
        rate = self.datadict['Valute']['UAH']['Value']
        previous = self.datadict['Valute']['UAH']['Previous']
        if diff == 'False':
            print(rate, ' за ', self.datadict['Valute']['UAH']['Nominal'], ' шт')
        else:
            print(round((rate-previous), 5))

    def data_file(self):
        with open('data.txt', 'w') as f:
            json.dump(full_data, f, ensure_ascii=False)



rate = Rate()


b = rate.max_rate()

c = rate.rate('AZN', 'True')

d = rate.uah_rate()










