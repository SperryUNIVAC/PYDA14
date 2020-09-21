my_list = ['a', 'b', 'c', 'd', 'e', 'f']

last_number = len(my_list) - 2
my_list_dict = dict.fromkeys([my_list[last_number]], my_list[-1:])

# немножко рекурсии
while last_number != 0:
    last_number -= 1
    my_list_dict = dict.fromkeys([my_list[last_number]], my_list_dict)
print(my_list_dict)


