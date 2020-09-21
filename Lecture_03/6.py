cook_book = {
'салат': [
{'ingridient_name': 'сыр', 'quantity': 50, 'measure': 'гр'},
{'ingridient_name': 'томаты', 'quantity': 20, 'measure': 'гр'},
{'ingridient_name': 'огурцы', 'quantity': 20, 'measure': 'гр'},
{'ingridient_name': 'маслины', 'quantity': 10, 'measure': 'гр'},
{'ingridient_name': 'оливковое масло', 'quantity': 20, 'measure': 'мл'},
{'ingridient_name': 'салат', 'quantity': 10, 'measure': 'гр'},
{'ingridient_name': 'перец', 'quantity': 20, 'measure': 'гр'}
],
'пицца': [
{'ingridient_name': 'сыр', 'quantity': 20, 'measure': 'гр'},
{'ingridient_name': 'колбаса', 'quantity': 30, 'measure': 'гр'},
{'ingridient_name': 'бекон', 'quantity': 30, 'measure': 'гр'},
{'ingridient_name': 'оливки', 'quantity': 10, 'measure': 'гр'},
{'ingridient_name': 'томаты', 'quantity': 20, 'measure': 'гр'},
{'ingridient_name': 'тесто', 'quantity': 100, 'measure': 'гр'},
],
'лимонад': [
{'ingridient_name': 'лимон', 'quantity': 1, 'measure': 'шт'},
{'ingridient_name': 'вода', 'quantity': 200, 'measure': 'мл'},
{'ingridient_name': 'сахар', 'quantity': 10, 'measure': 'гр'},
{'ingridient_name': 'лайм', 'quantity': 20, 'measure': 'гр'},
]
}

cook_type = input('введите желаемое блюдо - салат, пицца, лимонад: ')
guests_number = int(input('введите число гостей: '))

for i in range(0,len(cook_book[cook_type])):
    ingridient_type_name = cook_book[cook_type][i]['ingridient_name']
    ingridient_type_quantity = cook_book[cook_type][i]['quantity']*guests_number
    ingridient_type_measure = cook_book[cook_type][i]['measure'] 
    print(ingridient_type_name,': ',ingridient_type_quantity,' ',ingridient_type_measure)






