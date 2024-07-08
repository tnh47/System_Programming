def userpass():
    v8 = ">:~O5"
    v5 = [''] * 9
    v6 = "030951677"

    v0 = len(v6)
    for i in range(9):
        if i > 1:
            if i > 3:
                v5[i] = v8[8 - i]
            else:
                v5[i] = v6[i + 2]
        else:
            v5[i] = v6[i + 5]
  
    print("v5:", v5)
    res = ''
    for i in range(len(v6)):
        v2 = ((ord(v6[i]) + ord(v5[i])) // 2)
        res += chr(v2)  
    print(res)
userpass()


