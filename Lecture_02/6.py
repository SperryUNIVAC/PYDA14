# тут все просто

from math import sqrt

def Circle_area(R):
    return math.pi*(R**2)

def Triangle_area(A,B,C):
    p = (A+B+C)/2
    return sqrt(p*(p-A)*(p-B)*(p-C))

def Rectangle_area(A,B):
    return A*B

def Figure_convert(figure):
    figures = ['круг', 'треугольник', 'квадрат']
    try:
        return figures.index(figure) 
    except:
        raise ValueError('некорректно ведено название фигуры / данная фигура не поддерживается')   

print('Введите тип фигуры, допустимые варианты: круг, треугольник, прямоугольник')
figure = input()  # по-хорошему надо, опять таки, все проверять
Figure_type = Figure_convert(figure)

if Figure_type == 0:
   print("Введите радиус круга")
   R = int(input())
   print(Circle_area(R))

elif Figure_type == 1:
   print("Введите сторону A")
   A = int(input())
   print("Введите сторону B")
   B = int(input())
   print("Введите сторону C")
   C = int(input())
   if A + B > C and A + C > B and B + C > A: # проверка существования заданного треугольника
       print(Triangle_area(A,B,C))
   else:
       print("Треугольник не существует") 

elif Figure_type == 2:
   print("Введите сторону A")
   A = int(input())
   print("Введите сторону B")
   B = int(input())
   print(Rectangle_area(A,B))   

    
