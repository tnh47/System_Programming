def func4(a1, a2, a3):
    v4 = (a3 - a2) // 2 + a2
    if v4 <= a1:
        if v4 >= a1:
            return 0
        else:
            return 2 * func4(a1, v4 + 1, a3) + 1
    else:
        return 2 * func4(a1, a2, v4 - 1)

def find_a1():
    for a1 in range(15):
        if func4(a1, 0, 14) == 4:
            return a1

a1 = find_a1()
print("func4(a1, 0, 14) = 4 khi a1 =", a1)


