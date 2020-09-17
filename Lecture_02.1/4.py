# мне показалось скучным использовать готовый датесет и я решил 
# сформировать его интерактивно
running = True
data_set = []
while running:
       coutrie_name = input('Введите название страны ')
       coutrie_climat = input('Введите ряд температур ')
       list_coutrie_climat = coutrie_climat.replace(',', ' ').split()     
       data_set.append(coutrie_name)
       data_set.append(list_coutrie_climat)
       more_coutries = input('Хотите продолжить ввод? да/нет ')
       running = (more_coutries == 'да')
# отсюда начинается, собственно, задание
# все манипуляции мы честно производим с нашим готовым датасетом
# конечно смешно разбирать его обратно, но, заодно, мы получаем
# метод на любое количество стран, а не только четыре 
coutries_list = []
countries_climat = []
for i in range(0,len(data_set)):
    if type(data_set[i]) is str:
           coutries_list.append(data_set[i])
    else:
           countries_climat.append(data_set[i])
# разобрали, теперь посчитаем
print('Средняя температура по странам:')
countrie_climat = []
for i in range(0,len(countries_climat)):
    mediat_climat = 0
    for j in range(0,len(countries_climat[i])):
        mediat_climat += int(countries_climat[i][j])
    countrie_climat.append(mediat_climat)
    print(coutries_list[i],' - ',countrie_climat[i]/len(countrie_climat),' C')
 

