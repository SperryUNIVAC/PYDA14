import re

some_string = '''Напишите функцию функцию, которая будет будет будет будет
удалять все все все все последовательные повторы слов
из из из из заданной строки строки при помощи регулярных выражений'''

# здесь у меня непонятный облом. В сервисе regex101 прогон
# этого регекспа несколько раз приводит строку к нормальному виду, как
# заказывали, но здесь, почему-то этого не происходит

def duplicate_replacer(some_string):
    duplicate = r'(\w+) \1[^\w]'
    replace = r'\1'
    for i in range(0, len(some_string.split())):
        some_string = re.sub(duplicate, replace, some_string)
    return some_string

print(duplicate_replacer(some_string))

