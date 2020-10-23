class Employee:
    def __init__(self, name, accreditation):
        self.name = name
        self.accreditation = accreditation
        self.grade = 1     

    def grade_up(self):
        self.grade += 1

    def publish_grade(self):
        print(self.name, self.grade)

    def upgrade_employee(self):
        pass

class Developer(Employee):
    def __init__(self, name, accreditation):
        super().__init__(name, accreditation)   

    def upgrade_dev(self):
        self.accreditation += 1
        if self.accreditation %5 == 0:
            self.grade_up()
        return self.publish_grade

class Designer(Employee):
# добавим еще одну переменную - награды и введем общее количество баллов, это сумма аккредитаций и наград*2
    def __init__(self, name, accreditation, awards):
        super().__init__(name, accreditation)
        self.total_awards = accreditation + awards*2 

    def upgrade_des_awards(self):
        self.total_awards += 2 
        self.upgrade_des

    def upgrade_des_seniority(self):
        self.total_awards += 1
        self.upgrade_des
        
    def upgrade_des(self):   
# поскольку повышение происходит только на 1 или 2 балла, то мы можем или точно попасть в число, кратное, 7 или
# превзойти его на 1, значит повышаем сотрудника, если остаток от деления его баллов равен 0 или 1
        if self.total_awards >= 7 and (self.total_awards %7 == 0 or self.total_awards %7 == 1):
            self.grade_up()
        return self.publish_grade


alex = Developer('Alexander', 0)

petr = Designer('Petr', 0, 1)











