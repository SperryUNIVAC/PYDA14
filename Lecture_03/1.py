
ids = {'user1': [213, 213, 213, 15, 213],
'user2': [54, 54, 119, 119, 119],
'user3': [213, 98, 98, 35]}
# вытащим все значения и разгладим
ids_as_list = sum(ids.values(), [])
#почистим от дубликатов и отсортируем
print(sorted(set(ids_as_list)))
