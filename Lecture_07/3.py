import datetime

def data_range():
    start_date = input('Введите дату начала в формате YYYY-MM-DD ')
    end_date = input('Введите дату конца в формате YYYY-MM-DD ')
    try:
        y_start = int(start_date.split('-')[0])
        m_start = int(start_date.split('-')[1])
        d_start = int(start_date.split('-')[2])
        y_end = int(end_date.split('-')[0])
        m_end = int(end_date.split('-')[1])
        d_end = int(end_date.split('-')[2])
        start_datetime = datetime.datetime(y_start, m_start, d_start)
        end_datetime = datetime.datetime(y_end, m_end, d_end)
        if end_date <= start_date:
            print('Некорректный интервал')
        else:
            difference = end_datetime - start_datetime
            range_days = difference.days
            for i in range(1, difference.days+1):
                duration_day = datetime.timedelta(days=i)
                result = start_datetime + duration_day
                print(result)
    except ValueError:
        print('Кривой формат даты!')
    except IndexError:
        print('Кривой формат даты!')
