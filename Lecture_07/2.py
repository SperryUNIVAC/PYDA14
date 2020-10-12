import datetime


stream = ['2018-04-02', '2018-02-29', '2018-19-02']


for i in range(0, len(stream)):
    date = stream[i].split('-')
    datetime.date(int(date[0]), int(date[1]), int(date[2]))
    try:
        print('True')
    except ValueError:
        print('False')

