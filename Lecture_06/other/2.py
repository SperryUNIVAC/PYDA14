import re

some_string = '''Напишите функцию функцию, которая будет будет будет будет
удалять все все все все последовательные повторы слов
из из из из заданной строки строки при помощи регулярных выражений'''

def duplicate_replacer(some_string):
    duplicate = r'(\w+)(\s\1)+'
    replace = r'\1'
    some_string = re.sub(duplicate, replace, some_string)
    return some_string

print(duplicate_replacer(some_string))



