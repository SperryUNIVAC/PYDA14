import re

# создадим вспомогательные словари
# сначала подготовим словарь регионов, прочитав файл, который я выгрузил,
# ибо их там уж больно дофига, что бы вбивать руками

states_file = open('states.txt', 'r', encoding = 'ANSI')
states_dictionary = {}
states_str = states_file.readline()
while states_str: 
   # превратим строку в список, хитро разрезав по табуляции
    states_list = states_str.split('\t')
    st_key = int(states_list[0])
    st_value = states_list[1]
    states_dictionary.update({st_key: st_value[:-1]})
    states_str = states_file.readline()
states_file.close()

# подготовим словарь кодов на знаках транспортных средств ВС РФ
military_file = open('military.txt', 'r', encoding = 'ANSI')
military_dictionary = {}
military_str = military_file.readline()
while military_str: 
    military_list = military_str.split('\t')
    mil_key = int(military_list[0])
    mil_value = military_list[1]
    military_dictionary.update({mil_key: mil_value[:-1]})
    military_str = military_file.readline()
military_file.close()

# подготовим словарь кодов стран на автомобилях дип. представительств
ambassador_file = open('ambassador.txt', 'r', encoding = 'ANSI')
ambassador_dictionary = {}
ambassador_str = ambassador_file.readline()
while ambassador_str: 
    ambassador_list = ambassador_str.split('\t')
    am_key = int(ambassador_list[0])
    am_value = ambassador_list[1]
    ambassador_dictionary.update({am_key: am_value[:-1]})
    ambassador_str = ambassador_file.readline()
ambassador_file.close()

# захардкодим список регионов, где есть дип. представительства, их слишком мало
# что бы аналогично возится с файлом
ambs_list = [2, 7, 10, 16, 23, 24, 25, 27, 38, 39, 51, 52, 54, 55, 60, 61, 63, 65, 66, 77, 78, 99]

def if_number_is_white_test_func(test_number):
# этот кусок найдет стандартные номера частных автомобилей
    if re.fullmatch(r'([АВЕКМНОРСТУХабекмнорстух])\d{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}\d{2,3}|[АВЕКМНОРСТУХабекмнорстух]100[АВЕКМНОРСТУХабекмнорстух]{2}\d{2,3}', test_number):
    # отрежем кусок с номером региона, это, наверное, не лучший способ вытащить код области, но наименее эзотерический с моей тз
        result = re.split(r'[АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Private car number, Region: ', states_dictionary[state_number])                              
        else:
            print('xxx INVALID NUMBER xxx')
# этот кусок найдет федеральные номера 
    elif re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух][0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}', test_number):
        print('Federal car number')                             
# этот кусок найдет прицепы и внедорожные мототранспортные средства
    elif re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{3}[1-9][0-9]{2,3}', test_number):
        result = re.split(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{3}[1-9]', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Trailer or off-road transport, Region: ', states_dictionary[state_number])                            
        else:
            print('xxx INVALID NUMBER xxx')
# этот кусок найдет мотоциклы, тракторы, дорожно-строительные машины и прицепы к ним
    elif re.fullmatch(r'[0-9]{3}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        result = re.split(r'[0-9]{3}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Motorbikes, agrimotors or road construction machinery and his tralers number, Region:', states_dictionary[state_number])                             
        else:
            print('xxx INVALID NUMBER xxx')
# этот кусок найдет мопеды
    elif re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9][1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        result = re.split(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9][1-9][АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Moped number, Region: ', states_dictionary[state_number])                             
        else:
            print('xxx INVALID NUMBER xxx')
# этот кусок найдет классические автомобили
    elif re.fullmatch(r'К[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9][0-9]{2,3}', test_number):
        result = re.split(r'К[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9]', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Classic car number, Region: ', states_dictionary[state_number])                             
        else:
            print('xxx INVALID NUMBER xxx')
# этот кусок найдет классические мотоциклы
    elif re.fullmatch(r'К[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        result = re.split(r'К[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Classic motorbike number, Region: ',states_dictionary[state_number])                             
        else:
            print('xxx INVALID NUMBER xxx')
# этот кусок найдет спортивные автомобили
    elif re.fullmatch(r'С[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9][0-9]{2,3}', test_number):
        result = re.split(r'С[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9]', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Sportcar number, Region: ', states_dictionary[state_number])                                     
        else:
            print('xxx INVALID NUMBER xxx')
# этот кусок найдет спортивные  мотоциклы
    elif re.fullmatch(r'С[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        result = re.split(r'С[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Sportbike number, Region: ', states_dictionary[state_number])                             
        else:
            return('false')
# этот кусок найдет транзитные номера
    elif re.fullmatch(r'Т[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9][0-9]{2,3}', test_number):
        result = re.split(r'Т[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9]', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Transite number, Region: ', states_dictionary[state_number])                             
        else:
            print('xxx INVALID NUMBER xxx')
    else:
        print('xxx INVALID NUMBER xxx')


def if_number_is_blue_test_func(test_number):
    if re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух][0-9]{3}[1-9][0-9]{2,3}', test_number):
        result = re.split(r'[0-9]{3}[1-9]', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Police transport number, Region: ', states_dictionary[state_number])                             
        else:
            print('xxx INVALID NUMBER xxx')
    elif re.fullmatch(r'[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух][0-9]{2,3}', test_number):
        result = re.split(r'[АВЕКМНОРСТУХабекмнорстух]', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Police transport trailer number, Region: ', states_dictionary[state_number])                             
        else:
            print('xxx INVALID NUMBER xxx')
    else:
       print('xxx INVALID NUMBER xxx') 

def if_number_is_yellow_test_func(test_number):
    if re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9][0-9]{2,3}', test_number):
        result = re.split(r'[0-9]{2}[1-9]', test_number)
        state_number = int(result[1])
        if state_number in states_dictionary.keys():
            print('Public transport number, Region: ', states_dictionary[state_number])                             
        else:
            print('xxx INVALID NUMBER xxx')

def if_number_is_black_test_func(test_number):
    if re.fullmatch(r'[0-9]{3}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}', test_number):
        result = re.split(r'[АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        mil_number = int(result[1])
        if mil_number in military_dictionary.keys():
            print('Military transport number, Division: ', military_dictionary[mil_number])                             
        else:
            print('xxx INVALID NUMBER xxx')
    elif re.fullmatch(r'[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух][0-9]{2,3}', test_number):
        result = re.split(r'[АВЕКМНОРСТУХабекмнорстух]', test_number)
        mil_number = int(result[1])
        if mil_number in military_dictionary.keys():
            print('Military transport trailer number, Division: ', military_dictionary[mil_number])                             
        else:
            print('xxx INVALID NUMBER xxx')
    else:
       print('xxx INVALID NUMBER xxx') 

def if_number_is_red_test_func(test_number):
    if re.fullmatch(r'[0-9]{3}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}', test_number):
        result = re.split(r'[1-9][АВЕКМНОРСТУХабекмнорстух]{2}', test_number)
        amb_number = int(result[0])
        if amb_number in ambassador_dictionary.keys():
            print('Ambassador car number, affiliation: ', ambassador_dictionary[amb_number])                             
        else:
            print('xxx INVALID NUMBER xxx')
    elif re.fullmatch(r'[0-9]{2}[1-9][DTKMHP][0-9]{2}[1-9][0-9]{2}', test_number):
        result = re.split(r'[0-9]{2}[1-9][DTKMHP][0-9]{2}[1-9]', test_number)
        amb_number = int(result[0])
        state_number = int(result[1])
        if (amb_number in ambassador_dictionary.keys()) and (state_number in ambs_list):
            print('Ambassy vechicle number, affiliation: ', ambassador_dictionary[amb_number], 'Region: ', states_dictionary[state_number])                             
        else:
            print('xxx INVALID NUMBER xxx')
    elif re.fullmatch(r'[DTKMHP][0-9]{4}[1-9][0-9]{2}', test_number):
        result = re.split(r'[DTKMHP][0-9]{4}[1-9]', test_number)
        state_number = int(result[1])
        if state_number in ambs_list:
            print('Ambassy motorbyce number, Region: ', states_dictionary[state_number])                             
        else:
            print('xxx INVALID NUMBER xxx')           
    else:
       print('xxx INVALID NUMBER xxx')

def if_color_is_unknown_test_func(test_number):
    if re.fullmatch(r'([АВЕКМНОРСТУХабекмнорстух])\d{2}[1-9]\1{2}\d{2,3}|[АВЕКМНОРСТУХабекмнорстух]100[АВЕКМНОРСТУХабекмнорстух]{2}\d{2,3}'):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{3}[1-9][0-9]{2,3}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'[0-9]{3}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9][1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'К[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9][0-9]{2,3}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'К[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'С[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9][0-9]{2,3}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'С[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2,3}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух][0-9]{3}[1-9][0-9]{2,3}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух][0-9]{2,3}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'[АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}[1-9][0-9]{2,3}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'[0-9]{3}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'[0-9]{2}[1-9][АВЕКМНОРСТУХабекмнорстух][0-9]{2,3}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'[0-9]{3}[1-9][АВЕКМНОРСТУХабекмнорстух]{2}[0-9]{2}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'[0-9]{2}[1-9][DTKMHP][0-9]{2}[1-9][0-9]{2}', test_number):
        print('*** VALID NUMBER ***')
    elif re.fullmatch(r'[DTKMHP][0-9]{4}[1-9][0-9]{2}', test_number):
        print('*** VALID NUMBER ***')
    else:
        print('xxx INVALID NUMBER xxx')   

def main():
    print('Добро пожаловать в Определитель номеров. Для выхода введите q')
    print('Из-за особенностей индексации номеров, без указания цвета мы не сможем корректно определить регион или воинскую часть')
    print('В этом случае мы просто проверим, допустим ли такой номер')
    number_color = input('Введите цвет номера. Допустимые значения: белый, черный, желтый, синий, красный, не знаю ') 
    test_number = input('Введите номер для валидации: ')
    while (test_number !='q') or (number_color !='q'):
        if number_color == 'белый':
            if_number_is_white_test_func(test_number)
        elif number_color == 'черный':
            if_number_is_black_test_func(test_number)
        elif number_color == 'желтый':
            if_number_is_yellow_test_func(test_number)
        elif number_color == 'синий':
            if_number_is_blue_test_func(test_number)
        elif number_color == 'красный':
            if_number_is_red_test_func(test_number)
        elif number_color == 'не знаю':
            if_color_is_unknown_test_func(test_number)   
        number_color = input('Введите цвет номера. Допустимые значения: белый, черный, желтый, синий, красный, не знаю ')
        test_number = input('введите номер для валидации: ')
    else:
        print('exit')
    
