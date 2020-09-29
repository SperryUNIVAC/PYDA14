# сначала создадим словарь
purchase_log_file = open('purchase_log.txt', 'r', encoding = 'utf-8')
purchases_dictionary = {}
dict_str = purchase_log_file.readline()
while dict_str: 
    dict_list = dict_str.split('\"')
   # превратим строку в список, хитро разрезав по "
    purchases_dictionary.update({dict_list[3]: dict_list[7]})
    dict_str = purchase_log_file.readline()
# удалим лишнюю первую строку
del purchases_dictionary['user_id'] 

# теперь разберемся с логом
visit_log_file = open('visit_log.csv', 'r')
output_log = open('output_log.csv', 'w')
visit_log_str = visit_log_file.readline()
while visit_log_str:
    # порежем строку, что бы вытащить ID для поиска
    visit_log = visit_log_str.split(',')
    visit_log_str = visit_log_file.readline()
    # проверим, входит ли оно в словарь и если да, то допишем
    if visit_log[0] in purchases_dictionary.keys():
        data_0 = str(visit_log[0])
        data_1 = str(visit_log[1])
        data_2 = str(purchases_dictionary[visit_log[0]])
        # запишем данные, корректно их отформатировав
        text_for_file = data_0 + ' ' + data_1[:-1] + ' ' + data_2 + '\n'
        output_log.write(text_for_file)
# закроем все
output_log.close()
purchase_log_file.close()

















