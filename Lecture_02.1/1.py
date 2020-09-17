


test_string = input('Введите строку ')
if len(test_string)%2 == 0:
# ввел переменные, что бы не превращать в бесконечную лапшу print да и для отладки удобно
    a = len(test_string)//2-1 
    b = len(test_string)//2+1
    c = len(test_string)//2
    print(test_string[a:b])
else:
    print(test_string[c])



     
