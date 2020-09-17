# довольно громоздко, но короче мне уже лениво думать
set_of_numbers = input('введите ряд чисел ')
list_numbers = set_of_numbers.split()
int_lst = [int(x) for x in list_numbers]
final_list = []
unq_set_of_numbers = set(int_lst)
for i in range(0,len(int_lst)):
       if int_lst.count(int_lst[i]) > 1:
              final_list.append(int_lst[i])
# можно использовать множества, но хочется сохранить порядок без
# импорта всяких умных функций из разных библиотек
unique = []
[unique.append(item) for item in final_list if item not in unique]
print(unique)


