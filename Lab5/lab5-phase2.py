def reverse_transfer(s):
    result = []
    for char in s:
        if 'a' <= char <= 'z':
            new_char = chr((ord(char) - ord('a') - 7 + 26) % 26 + ord('a'))
        elif 'A' <= char <= 'Z':
            new_char = chr((ord(char) - ord('A') - 7 + 26) % 26 + ord('A'))
        elif '0' <= char <= '9':
            new_char = chr((ord(char) - ord('0') - 7 + 10) % 10 + ord('0'))
        else:
            new_char = char
        result.append(new_char)
    return ''.join(result)

output = "Dpukvd"
input_string = reverse_transfer(output)
print(f"{input_string}")


