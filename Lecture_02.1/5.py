# так как писать датасет я уже попробовал в предыдущей задаче,
# тут мне то делать лениво да и излошне
# в конце концов логи откуда-то готовые падают
stream = [
'2018-01-01,user1,3',
'2018-01-07,user1,4',
'2018-03-29,user1,1',
'2018-04-04,user1,13',
'2018-01-05,user2,7',
'2018-06-14,user3,4',
'2018-07-02,user3,10',
'2018-03-21,user4,19',
'2018-03-22,user4,4',
'2018-04-22,user4,8',
'2018-05-03,user4,9',
'2018-05-11,user4,11',
]
# сначала распотрошим лог и выколупаем оттуда всех юзеров и все обращения
# ох как весело бы это все делать регэкспами, но я их сам плохо помню
# порежем каждую строку
general_list = []
for i in range(0,len(stream)):
       general_list.append(stream[i].split(','))
# разгладим
general_list = sum(general_list, [])
# и выкинем весь мусор и все посортируем
# наверное, можно даже без регэкспов это сделать как-то красивее
# но я применил грязных хак выколупывания по номеру
user_list = []
user_list.append(general_list[1])
for i in range(1,len(general_list)-4,3):
       user_list.append(general_list[i+3])
browsing_list = []
browsing_list.append(general_list[2])
for i in range(2,len(general_list)-3,3):
       browsing_list.append(general_list[i+3])
# и посчитаем
unq_user = len(set(user_list))
int_lst = [int(x) for x in browsing_list]
browsing = sum(int_lst)
unq_per_user = browsing/unq_user
print(unq_per_user)
