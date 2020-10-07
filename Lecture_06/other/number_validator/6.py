import re

test_numbers_valid = ['89215380431', '8921 538 04 31', '8-921-5380431', '8 (921) 5380431', '+7(921) 5380431']
test_numbers_invalid = []

# первая цифра опкода - всегда 9, среди 2х оставшихся эти НЕ встречаются
# это намного проще, чем искать среди 70+ встречающихся и легче модифицировать
# если какой-то из этих займет новый оператор
invalid_opcodes_list = [7,40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 54, 55, 56, 57, 59, 70, 71, 72, 73, 74, 75, 76, 79, 90, 97, 98]

# на вход подается список номеров (сделал так ибо пачкой их тестить было сильно проще, можно цикл убрать и будет для одного номера)
def phone_validator(numbers_list):
    for i in range(0, len(numbers_list)):
        # вычистим весь мусор
        test_number_clean = re.sub(r' |\(|\)|\+|-', '', numbers_list[i])   
        # теперь осталось только проверить, подходит ли номер по формату
        # если номер начинается с 7 или 8 
        condition_first_78 = re.fullmatch(r'[7,8][9]\d{9}', test_number_clean)
        condition_lenght_78 = len(test_number_clean) == 11
        # если номер начинается с 9
        condition_first_9 = re.fullmatch(r'[9]\d{9}', test_number_clean)
        condition_lenght_9 = len(test_number_clean) == 10
        # совпадают ли коды операторов
        condition_opcodes_78 = re.match(r'(?<=[7,8]9)\d{2}', test_number_clean) not in invalid_opcodes_list
        condition_opcodes_9 = re.match(r'(?<=9)\d{2}', test_number_clean) not in invalid_opcodes_list
        if condition_first_78 and condition_lenght_78 and condition_opcodes_78:
        # в этом месте какой-то странный косяк с заменой снова, в проверялке регэкспов
        # все работает как часы, а тут меняет на хз что почему-то    
            number = re.sub(r'[7,8](\d{3})(\d{3})\d{2}(\d{2})', '\+7-\1-\2-\3', test_number_clean) 
        elif condition_first_9 and condition_lenght_9 and condition_opcodes_9:
            number = re.sub(r'(\d{3})(\d{3})\d{2}(\d{2})', '\+7-\1-\2-\3', test_number_clean)
        else:
            number = '*** INVALID NUMBER ***'
        print(number)
    


