import re

test_string = '''Эталонной реализацией Python является интерпретатор CPython, поддерживающий
большинство активно используемых платформ. Он распространяется под свободной лицензией Python
Software Foundation License, позволяющей использовать его без ограничений в любых приложениях,
включая проприетарные.'''


def vovels_consonans_test(test_string):
    rus_vovels = r'( [я, у, о, ы, и, э, я, ю, ё, е]\w+)'
    rus_consonants = r'( [б, в, г, д, ж, з, й, к, л, м, н, п, р, с, т, ф, х, ц, ч, ш, щ]\w+)'
    eng_vovels = r'( [a, e, i, o, u]\w+)'
    eng_consonants = r'( [b, c, d, f, g, h, j, k, l, m, n, p, q, r, s, t, v, w, x, y, z]\w+)'

    rus_vovels_list = re.findall(rus_vovels, test_string, flags = re.I)
    rus_consonants_list = re.findall(rus_consonants, test_string, flags = re.I)
    eng_vovels_list = re.findall(eng_vovels, test_string, flags = re.I)
    eng_consonants_list = re.findall(eng_consonants, test_string, flags = re.I)

    print('Слов на гласные буквы: ', len(rus_vovels_list)+len(eng_vovels_list))
    print('Слов на согласные буквы: ', len(rus_consonants_list)+len(eng_consonants_list))



