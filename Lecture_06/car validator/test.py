import re

t_list = []
t_sublist = []

test_file = open('test.txt', 'r', encoding = 'ANSI')
test_str = test_file.readline()
while test_str: 
    test_list = test_str.split('\t')
    t_sublist.append(test_list[0])
    t_sublist.append(test_list[1])
    t_sublist.append(test_list[2][:-1])
    t_list.append(t_sublist)
    t_sublist = []
    test_str = test_file.readline()
test_file.close()

states_file = open('states.txt', 'r', encoding = 'ANSI')
states_dictionary = {}
states_str = states_file.readline()
while states_str: 
    states_list = states_str.split('\t')
    st_key = int(states_list[0])
    st_value = states_list[1]
    states_dictionary.update({st_key: st_value[:-1]})
    states_str = states_file.readline()
states_file.close()

def if_number_is_white_test_func(test_number):
# этот кусок найдет стандартные номера частных автомобилей
    if re.fullmatch(r'([АВЕКМНОРСТУХабекмнорстух])\d{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}\d{2,3}|[АВЕКМНОРСТУХабекмнорстух]100[АВЕКМНОРСТУХабекмнорстух]{2}\d{2,3}', test_number):
    # отрежем кусок с номером региона, это, наверное, не лучший способ вытащить код области, но наименее эзотерический с моей тз
        result = re.split(r'[АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            return('true')                             
        else:
            return('false')
# этот кусок найдет федеральные номера 
    elif re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух][0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}', test_number):
        print('Federal car number')                             
# этот кусок найдет прицепы и внедорожные мототранспортные средства
    elif re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{3}[1-9][0-9]{2,3}', test_number):
        result = re.split(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{3}[1-9]', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            return('true')                             
        else:
            return('false')
# этот кусок найдет мотоциклы, тракторы, дорожно-строительные машины и прицепы к ним
    elif re.fullmatch(r'[0-9]{3}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        result = re.split(r'[0-9]{3}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            return('true')                             
        else:
            return('false')
# этот кусок найдет мопеды
    elif re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9][1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        result = re.split(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9][1-9][АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            return('true')                             
        else:
            return('false')
# этот кусок найдет классичкеские автомобили
    elif re.fullmatch(r'К[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9][0-9]{2,3}', test_number):
        result = re.split(r'К[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9]', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            return('true')                             
        else:
            return('false')
# этот кусок найдет классические мотоциклы
    elif re.fullmatch(r'К[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        result = re.split(r'К[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            return('true')                             
        else:
            return('false')
# этот кусок найдет спортивные автомобили
    elif re.fullmatch(r'С[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9][0-9]{2,3}', test_number):
        result = re.split(r'С[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9]', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            return('true')                             
        else:
            return('false')
# этот кусок найдет спортивные  мотоциклы
    elif re.fullmatch(r'С[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        result = re.split(r'С[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            return('true')                             
        else:
            return('false')
# этот кусок найдет транзитные номера
    elif re.fullmatch(r'Т[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9][0-9]{2,3}', test_number):
        result = re.split(r'Т[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9]', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            return('true')                             
        else:
            return('false')
    else:
        return('false')


for i in range(0, len(t_list)):
    number = int(t_list[i][0])
    result = if_number_is_white_test_func(t_list[i][1])
    correct_result = t_list[i][2]
    print(number, result, correct_result)




