import re

emails_list = ['test@gmail.com', 'xyz@test.in', 'test@ya.ru', 'xyz@mail.ru', 'xyz@ya.ru', 'xyz@gmail.com']

def emails(emails_list):
# превратим список в строку
    emails_string = ''.join(emails_list)
# двойным применением findall вытащим домены
    domen_name = re.findall(r'\w+\.\w{2,3}', str(re.findall(r'@\w+\.\w{2,3}', emails_string)))
# итерируемся по количеству унгикальных элементов
    for i in range(0, len(set(domen_name))):
        number = domen_name.count(domen_name[i])
        print(domen_name[i], number)


