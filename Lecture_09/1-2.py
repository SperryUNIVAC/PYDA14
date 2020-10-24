import numpy as np

# создадим перевернутый массив
N = int(input('Введите N: '))
first_array = np.array(list(reversed([i for i in range(0,N)])))
print(first_array)

# создадим из него диагональную матрицу
mat = np.diag(first_array)
print(mat)

# найдем след матрицы
print(np.trace(mat))

