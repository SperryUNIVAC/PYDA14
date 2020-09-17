


# в разумных пределах ограничения на запись нет, можно писать через пробел или запятую или запятую и пробел
string_boys = input('Введите имена мальчиков ')
string_girls = input('Введите имена девочек ')

# на всякий случай уберем потенциальные запятые, если кто-то их поставил 
list_boys = string_boys.replace(',', ' ').split() 
list_girls = string_girls.replace(',', ' ').split()
if len(list_boys) != len(list_girls):
    print('Внимание, кто-то может остаться без пары!')
else:
    sorted(list_boys)
    sorted(list_girls)    
    print('Идеальные пары:')   
    for i in range(0,len(list_boys)):
        print(list_boys[i],' и ',list_girls[i])






     
