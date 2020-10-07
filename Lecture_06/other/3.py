import re

some_string = 'Near field communication'

# конечно это не за один-единственный регексп, но этот код куда
# понятнее и читабельнее и регекспы в нем тоже есть

def abbreviation(some_string):
    some_string = some_string.upper()
    word = re.findall(r'\w+', some_string)
    for i in range(0, len(some_string.split())):
        first_letter = re.findall(r'\w', word[i])[0]
        abbreviation = re.sub(word[i], first_letter, some_string)
        some_string = abbreviation
    abbreviation = abbreviation.replace(' ', '') 
    return abbreviation

print(abbreviation(some_string))

