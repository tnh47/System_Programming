arr = [10, 2, 14, 7, 8, 12, 15, 11, 0, 4, 1, 13, 3, 9, 6, 5]

for i in range (0,100):
    v3 = i & 15
    count = 0
    sum = 0
    while v3 != 15:
        v3 = arr[v3]
        count += 1
        sum += v3
    if count == 9:
        print (f"v3: {i} - v6: {count} - v7: {sum}")


        