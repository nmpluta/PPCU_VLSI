abc_morse = ".- -... -.-."                  # ABC
sos_morse = "... --- ..."                   # SOS
name_morse = "-. .- - .- .-.. .. .-"        # Natalia
surname_morse = ".--. .-.. ..- - .-"        # Pluta

list_morse = [abc_morse, sos_morse, name_morse, surname_morse]
output_list = [[], [], [], []]

for index, code in enumerate(list_morse):
    for signal in code:
        if signal == '.':
            output_list[index].append(1)
            output_list[index].append(0)
        elif signal == '-':
            output_list[index].append(1)
            output_list[index].append(1)
            output_list[index].append(1)
            output_list[index].append(0)
        else:
            output_list[index].append(0)
            output_list[index].append(0)
    output_list[index] = output_list[index][ : -1]
    print(output_list[index])
        # print(signal)