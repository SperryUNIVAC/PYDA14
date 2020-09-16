# сразу хочу предупредить, что зодиаков существует много, как минимум, астрономический и астрологический
# при этом астрологических тоже дофига, как минимум, корректный астрономически, т.е учитывающий прецессию звезд
# и традиционный, ничего не учитывающий и вообще не имеющий отношения к современной звездной карте. Для простоты примем
# что мы имеем дело с классическим эллинским зодиаком

# преобразование месяца в число, довольно тонкий хак
def month_convert(month):
    months = ['январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь']
    try:
        return months.index(month) + 1
    except:
        raise ValueError('некорректно ведено название месяца / это не месяц')   
  
print('Введите день вашего рождения')
date = int(input())  #по-хорошему надо  опять таки все проверять
print('Введите месяц вашего рождения')
String_month = input()
Month = month_convert(String_month)
if (date >= 21 and date <= 31 and Month == 3) or( Month == 4 and date >= 1 and date <= 19):
   print("Знак зодиака:Овен")
elif (date >= 20 and date <= 30 and Month == 4) or( Month == 5 and date >= 1 and date <= 20):
   print("Знак зодиака:Телец")
elif (date >= 21 and date <= 31 and Month == 5) or( Month == 6 and date >= 1 and date <= 21):
   print("Знак зодиака:Близнецы")
elif (date >= 22 and date <= 30 and Month == 6) or( Month == 7 and date >= 1 and date <= 22):
   print("Знак зодиака:Рак")
elif (date >= 23 and date <= 31 and Month == 7) or( Month == 8 and date >= 1 and date <= 22):
   print("Знак зодиака:Лев")
elif (date >= 23 and date <= 31 and Month == 8) or( Month == 9 and date >= 1 and date <= 22):
   print("Знак зодиака:Дева")
elif (date >= 23 and date <= 30 and Month == 9) or( Month == 10 and date >= 1 and date <= 23):
   print("Знак зодиака:Весы")
elif (date >= 24 and date <= 31 and Month == 10) or( Month == 11 and date >= 1 and date <= 22):
   print("Знак зодиака:Скорпион")
elif (date >= 23 and date <= 30 and Month == 11) or( Month == 12 and date >= 1 and date <= 21):
   print("Знак зодиака:Стрелец")
elif (date >= 22 and date <= 31 and Month == 12) or( Month == 1 and date >= 1 and date <= 20):
   print("Знак зодиака:Козерог")
elif (date >= 21 and date <= 31 and Month == 1) or( Month == 2 and date >= 1 and date <= 18):
   print("Знак зодиака:Водолей")
elif (date >= 19 and date <= 29 and Month == 2) or( Month == 3 and date >= 1 and date <= 20):
   print("Знак зодиака:Рыбы")






