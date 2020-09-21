results = {
'vk': {'revenue': 103, 'cost': 98},
'yandex': {'revenue': 179, 'cost': 153},
'facebook': {'revenue': 103, 'cost': 110},
'adwords': {'revenue': 35, 'cost': 34},
'twitter': {'revenue': 11, 'cost': 24},
}

# поразительно, как мало места занимает этот код, но
# разбираясь с ним я так упоролся, что писать сортировку по ключам
# мне уже очень лениво, в итоге вывод будет в таком же порядке, что и ввод
# это я писал еще до практики по словарям

for key, value in results.items():
    roi = (value['revenue']/value['cost']-1)*100
    results[key].setdefault('ROI', round(roi,2))
print(results)

# после практики я вдохновился и решил, что можно таки прикрутить сортировку
# для этого я создал новый словарь и заполнил его в правильном порядке

list_keys = sorted(list(results.keys()))
sorted_results = {}

for k in list_keys:
    format_results = {}
    format_results.setdefault('ROI', results[k]['ROI'])
    format_results.setdefault('revenue', results[k]['revenue'])
    format_results.setdefault('cost', results[k]['cost'])
    sorted_results.setdefault(k, format_results)
print(sorted_results)


