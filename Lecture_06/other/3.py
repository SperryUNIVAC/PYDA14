import re

some_string = 'Near field communication'

def abbreviation(some_string):
    some_string = some_string.upper()
    find = r'(\w)\w+.'
    replace = r'\1'
    abbreviation = re.sub(find, replace, some_string)
    return abbreviation
print(abbreviation(some_string))

