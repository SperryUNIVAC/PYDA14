import datetime
import calendar
import re

month_dict = {name: num for num, name in enumerate(calendar.month_abbr) if num}



mt_date = 'Wednesday, October 2, 2002'
g_date = 'Friday, 11.10.13'
dn_date = 'Thursday, 18 August 1977'


def the_moscow_times_date(mt_date):
    mt_date = mt_date.replace(',', '')
    year_mt_date = int(mt_date.split()[3])
    month_mt_date = month_dict[mt_date.split()[1][0:3]]
    day_mt_date = int(mt_date.split()[2])
    print(datetime.date(year_mt_date, month_mt_date, day_mt_date))


def the_guardian_date(g_date):
    g_date = g_date.split()[1]
    g_date_year = re.search(r'(\d\d)(\.)(\d\d)(\.)(\d\d)', g_date)
    g_date = g_date.replace(g_date_year[5], '20'+g_date_year[5])
    g_date = re.sub(r'(\.)', '/', g_date)
    print(datetime.strptime(g_date, "%d/%m/%Y"))


def daily_news(dn_date):
    dn_date = dn_date.replace(',', '')
    year_dn_date = int(dn_date.split()[3])
    month_dn_date = month_dict[dn_date.split()[2][0:3]]
    day_dn_date = int(dn_date.split()[1])
    print(datetime.date(year_dn_date, month_dn_date, day_dn_date))
