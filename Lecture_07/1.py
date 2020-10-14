import datetime
import calendar
import re

month_dict = {name: num for num, name in enumerate(calendar.month_abbr) if num}

mt_date = 'Wednesday, October 2, 2002'
g_date = 'Saturday, 11.10.13'
dn_date = 'Thursday, 18 August 1977'


def the_moscow_times_date(mt_date):
    mt_date = mt_date.replace(',', '')
    year_mt_date = int(mt_date.split()[3])
    month_mt_date = month_dict[mt_date.split()[1][0:3]]
    day_mt_date = int(mt_date.split()[2])
    print(datetime.date(year_mt_date, month_mt_date, day_mt_date))

# я изменил и усложнил эту функцию
# я видел этот косяк еще когда сдавал, но не имел времени его поправить
# во-первых, у меня некорректно срабатывал strptime, теперь все ок
# во-вторых, я интерпретировал 11.10.13 как 2013 год, это было сделано
# умышленно для простоты, хотя, естествено, функция выдавала бы неверный ответ
# если год 1913. Теперь я добавил проверку, всегда возвращающую
# именно тот год, который имелся в виду
# проверки ради я поменял в дате пятницу на субботу, что соответствует 1913 году

def the_guardian_date(g_date):
    test_g_date = g_date.split()[1]
    g_date_year = re.search(r'(\d\d)(\.)(\d\d)(\.)(\d\d)', test_g_date)
    test_g_date = test_g_date.replace(g_date_year[5], '20'+g_date_year[5])
    test_g_date = re.sub(r'(\.)', '/', test_g_date)
    my_date = datetime.datetime.strptime(test_g_date, "%d/%m/%Y")
    if calendar.day_name[my_date.weekday()] == g_date.replace(',', '').split()[0]:
        print(my_date)
    else:
        test_g_date = g_date.split()[1]
        g_date_year = re.search(r'(\d\d)(\.)(\d\d)(\.)(\d\d)', test_g_date)
        test_g_date = test_g_date.replace(g_date_year[5], '19'+g_date_year[5])
        test_g_date = re.sub(r'(\.)', '/', test_g_date)
        my_date = datetime.datetime.strptime(test_g_date, "%d/%m/%Y") 
        print(my_date)

def daily_news(dn_date):
    dn_date = dn_date.replace(',', '')
    year_dn_date = int(dn_date.split()[3])
    month_dn_date = month_dict[dn_date.split()[2][0:3]]
    day_dn_date = int(dn_date.split()[1])
    print(datetime.date(year_dn_date, month_dn_date, day_dn_date))
