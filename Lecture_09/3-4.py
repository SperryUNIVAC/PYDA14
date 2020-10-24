import numpy as np


a = np.array([[4,2,1], [1,3,0], [0,5,4]], float)
b = np.array([[4], [12], [-3]], float)



# Тест на совместность
# воспользуемся критерием Кронекера-Капелли и установим, совместна ли система
c = np.concatenate((a,b), axis=1)
print(np.linalg.matrix_rank(a) == np.linalg.matrix_rank(c))

# Тест на определенность
print(np.linalg.matrix_rank(a) == len(a[1]))

# Тест на однородность
print(any(b != 0))

print(np.linalg.solve(a, b))



user_stats = np.array(
    [
        [2, 1, 0, 0, 0, 0],
        [1, 1, 2, 1, 0, 0],
        [2, 0, 1, 0, 0, 0],
        [1, 1, 2, 1, 0, 1],
        [0, 0, 1, 1, 0, 0],
        [0, 0, 0, 2, 0, 5],
        [1, 0, 0, 0, 0, 0],
        [0, 1, 1, 0, 0, 0],
        [0, 0, 0, 1, 1, 3],
        [1, 0, 0, 2, 1, 4]
    ], np.int32
)

next_user_stats = np.array([0, 1, 2, 0, 0, 0])


def myfunction(x):
    return np.dot(x, next_user_stats)/(np.linalg.norm(user_stats[0]) * np.linalg.norm(x))

cos_list = list(np.apply_along_axis(myfunction, axis = 1, arr = user_stats))

 
print(user_stats[cos_list.index(max(cos_list))])


