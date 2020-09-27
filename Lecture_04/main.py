'''
багфиксы:
1. Добавление документа - исправлено перестановкой действий, теперь скрипт сначала
проверяет, создана ли полка и если нет, ничего никуда не добавляет.
2. Удаление документа - там вообще был ад кошмара, я эту функцию, вроде,
трезвый писал, но что-то нагородил невменяемого, все переписал.
Страннее всего, что я как-то пролюбил этот момент, я же их все два раза тестил, по идее,
один раз голую функцию и второй раз, когда все уже собрал. Ну второй раз возможно я ее и забыл,
но в первый-то оно должно было работать со всеми параметрами возможными.. В общем очень странно, как
я это упустил.
3. Перемещение несуществующего документа - добавил обработчик.
4. Немного изменил information_func(len_list), добавил ей параметр длины списка,
иначе некорректно обрабатывала выдачу после измененной длины списка после удаления документа
5. Из get_key_func выкинул print, там забавные побочные эффекты возникали в паре мест,
когда она печатала там, где не надо
'''

documents_list = [
{'type': 'passport', 'number': '2207 876234', 'name': 'Василий Гупкин'},
{'type': 'invoice', 'number': '11-2', 'name': 'Геннадий Покемонов'},
{'type': 'insurance', 'number': '10006', 'name': 'Аристарх Павлов'}
]

# обратите внимание - здесь ключи в словаре являются целыми
# т.к я счел, что это логичнее - это же номера полок.
# тем не менее, нет никаких проблем переделать это все и для произвольного типа

directories_dict = {1: ['2207 876234', '11-2'], 2: ['10006'], 3: []}


# две вспомогательные функции - одна возвращает ключ по значению и
# используется далее в куче проверок
def get_key_func(val, directory):
    """
    функция, которая возвращает ключ по значению
    """
    for key, value in directory.items():
        if val in value:
           return key       

# и функция печати полной информации
# нужна и сама по себе и встроена в кучу функций ниже
def information_func(len_list):
    """
    получение информации и печать
    """
    print('Текущий список документов: ')
    for i in range(0,len_list):
        print('№: ', documents_list[i]['number'],' тип: ', documents_list[i]['type'],
               ' владелец: ', documents_list[i]['name'], ' полка хранения: ',
               get_key_func(documents_list[i]['number'], directories_dict))

# а это уже основные функции
def relocated_func():
    """
    перемещение документа
    """
    number_doc = input('Введите номер документа: ')
    number_dict = int(input('Введите номер полки: '))
    # проверка на существование полки
    if not number_dict in directories_dict.keys():
        print('Такой полки не существует. Текущий перечень полок: ',
                 *directories_dict, ' Добавьте полку командой as.')
    # проверка на существование документа и одновременно вытаскивание ключа
    else:
        key = get_key_func(number_doc, directories_dict)
        if not key:
            print('Документ не существует!')
        else:
    # удаление ключа
            delete_list = list(directories_dict[key])
            delete_list.remove(number_doc)
            directories_dict.update({key: delete_list})
    # добавление ключа
            insert_list = list(directories_dict[number_dict])
            insert_list.append(number_doc)
            directories_dict.update({number_dict: insert_list})
            print('Документ перемещен.')
            information_func()

def create_new_doc_func():
    """
    добавление документа
    """
    # создаем новую пустую строку под словарь documents
    documents_list_dict = {}
    # блок ввода для команды ad
    type_doc = input('Введите тип документа: ')
    number_doc = input('Введите номер документа: ')
    name_doc = input('Введите владельца документа: ')
    dir_doc = int(input('Введите полку для хранения: '))
    # заполнение нового словаря 
    documents_list_dict.setdefault('type', type_doc)
    documents_list_dict.setdefault('number', number_doc)
    documents_list_dict.setdefault('name', name_doc)   
    # прописать документ в directories    
    if dir_doc in directories_dict.keys():
    # если ключ есть, то мы добавляем лист в этот ключ
        directories_dict.setdefault(dir_doc, []).append(number_doc)
        # добавление нового словаря в список documents
        documents_list.append(documents_list_dict)
        print('Документ добавлен.')
        information_func(len(documents_list))
    else:
        print('Такой полки не существует. Текущий перечень полок: ',
                 *directories_dict, ' Добавьте полку командой as.')

def del_doc_func():
    """
    удаление документа
    """
    number_doc = input('Введите номер документа: ')    
    for i in range(0, len(documents_list)):
        if number_doc in documents_list[i].values():
            del documents_list[i]
            key = get_key_func(number_doc, directories_dict)
            delete_num = list(directories_dict[key])
            delete_num.remove(number_doc)
            directories_dict.update({key: delete_num})
            break
    else:
        print('Документ не найден в базе.')
        information_func(len(documents_list))
    print('Документ удален.')
    information_func(len(documents_list))

def create_new_dir_func():
    """
    создание новой полки
    """
    key = int(input('Введите номер полки: '))
    if key in directories_dict.keys():
        print('Такая полка уже существует. Текущий перечень полок: ', *directories_dict)
    else:
        directories_dict.update({key: []})
        print('Полка добавлена. Текущий перечень полок: ', *directories_dict)

def delete_dir_func():
    """
    удаление полки
    """ 
    key = int(input('Введите номер полки: '))
    if key in directories_dict.keys():
        if not directories_dict[key]:
            directories_dict.pop(key, None)
            print('Полка удалена. Текущий перечень полок: ', *directories_dict)
        else:
            print('На полке есть документы, удалите их перед удалением полки. Текущий перечень полок: ', *directories_dict)
    else:
       print('Перед тем, как удалить полку, ее следует добавить!Текущий перечень полок: ', *directories_dict) 

def master_func():
    """
    кто хозяин?
    """    
    number_doc = input('Введите номер документа: ')
    for i in range(0, len(documents_list)):
        if number_doc in documents_list[i].values():
            print('Владелец документа: ', documents_list[i]['name'])
            break
    else:      
        print('Документ не найден в базе.')

def find_directory_func():
    """
    где директория?
    """ 
    number_doc = input('Введите номер документа: ')
    if get_key_func(number_doc, directories_dict):
        print('Полка хранения: ', get_key_func(number_doc, directories_dict))
    else:
        print('Документ не найден в базе.')

def main():
    print('Добро пожаловать в скрипт Автоматический секретарь 1.0')
    while True:
        command = input('введите команду: ')
        if command == 'p':
            master_func()
        elif command == 's':
            find_directory_func()
        elif command == 'l':
            information_func(len(documents_list))
        elif command == 'as':
            create_new_dir_func()
        elif command == 'ds':
            delete_dir_func()
        elif command == 'ad':
            create_new_doc_func()
        elif command == 'd':
            del_doc_func()
        elif command == 'm':
            relocated_func()                    
        elif command == 'q':
            print('exit')
            break
        
        
        


   
