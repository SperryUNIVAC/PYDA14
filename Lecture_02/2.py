# существует много календарей и, соответственно, много систем подсчета високосных дней
# тут представлены юлианский, григорианский и еврейский
# хотел сделать еще исламский, но там настолько невменяемые алгоритмы подсчета (да и, строго говоря,
# там, скорее високосные месяцы, а не годы), что проще его просто табличкой захардкодить


def JulLeapYear(year): #юлианский
    if year % 4 == 0:
        return True
    else:
        return False

def GregLeapYear(year): #григорианский
    if year % 4 == 0 and year % 100 != 0 or year % 400 == 0:
        return True
    else:
        return False

def HebrLeapYear(year): #еврейский
    if ((((year*7)+1) % 19) < 7):
        return True
    else:
        return False

# поехали считать
print('Введите год')
year = int(input())  #по-хорошему надо проверить, год ли вообще ввел юзер, но мне лениво
print('Введите цифрой вид календаря, по которому вы желаете определить високосность года: 1 - Юлианский, 2 - Григорианский, 3 - Еврейский')
Cal_type = int(input())
Cal_var = [1,2,3] #зато проверим, корректно ли он обозначил календарь
if Cal_type in Cal_var:
   if Cal_type == 1:
       print(JulLeapYear(year))
   elif Cal_type == 2:
       print(GregLeapYear(year))
   elif Cal_type == 3:
       print(HebrLeapYear(year))
else: 
    print('Вы некорректно ввели тип календаря, попробуйте перезапустить скрипт')
