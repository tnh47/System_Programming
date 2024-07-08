.section .data
msg_input:
        .string "Enter a number : "   # Chuỗi để yêu cầu nhập số
        len = . -msg_input             # Độ dài của chuỗi msg_input
newline:
        .string "\n"                   # Chuỗi xuống dòng

.section .bss
        .lcomm num1, 3   # Khai báo một biến num1, kích thước 3 bytes 
        .lcomm num2, 3   # Khai báo một biến num2, kích thước 3 bytes 
        .lcomm num3, 3   # Khai báo một biến num3, kích thước 3 bytes 
        .lcomm num4, 3   # Khai báo một biến num4, kích thước 3 bytes 
        .lcomm avg, 3    # Khai báo một biến avg, kích thước 3 bytes 

.section .text        
.globl _start
_start:

        # In chuỗi yêu cầu nhập số
        movl $4, %eax       # Số gọi hệ thống cho syscall write
        movl $1, %ebx       # Đầu ra chuẩn (stdout)
        movl $msg_input, %ecx  # Địa chỉ của chuỗi msg_input
        movl $len, %edx     # Độ dài của chuỗi msg_input
        int $0x80           # Gọi hệ thống kernel để in chuỗi

        # Đọc số từ bàn phím vào biến num1
        movl $3, %eax       # Số gọi hệ thống cho syscall read
        movl $0, %ebx       # Đầu vào chuẩn (stdin)
        movl $num1, %ecx    # Địa chỉ của biến num1
        movl $3, %edx       # Độ dài tối đa được đọc (3 bytes)
        int $0x80           # Gọi hệ thống kernel để đọc dữ liệu

        # In chuỗi yêu cầu nhập số (lần thứ hai)
        movl $4, %eax       # Số gọi hệ thống cho syscall write
        movl $1, %ebx       # Đầu ra chuẩn (stdout)
        movl $msg_input, %ecx  # Địa chỉ của chuỗi msg_input
        movl $len, %edx     # Độ dài của chuỗi msg_input
        int $0x80           # Gọi hệ thống kernel để in chuỗi

        # Đọc số từ bàn phím vào biến num2
        movl $3, %eax       # Số gọi hệ thống cho syscall read
        movl $0, %ebx       # Đầu vào chuẩn (stdin)
        movl $num2, %ecx    # Địa chỉ của biến num2
        movl $3, %edx       # Độ dài tối đa được đọc 
        int $0x80           # Gọi hệ thống kernel để đọc dữ liệu

        # In chuỗi yêu cầu nhập số (lần thứ ba)
        movl $4, %eax       # Số gọi hệ thống cho syscall write
        movl $1, %ebx       # Đầu ra chuẩn (stdout)
        movl $msg_input, %ecx  # Địa chỉ của chuỗi msg_input
        movl $len, %edx     # Độ dài của chuỗi msg_input
        int $0x80           # Gọi hệ thống kernel để in chuỗi

        # Đọc số từ bàn phím vào biến num3
        movl $3, %eax       # Số gọi hệ thống cho syscall read
        movl $0, %ebx       # Đầu vào chuẩn (stdin)
        movl $num3, %ecx    # Địa chỉ của biến num3
        movl $3, %edx       # Độ dài tối đa được đọc 
        int $0x80           # Gọi hệ thống kernel để đọc dữ liệu

        # In chuỗi yêu cầu nhập số (lần thứ tư)
        movl $4, %eax       # Số gọi hệ thống cho syscall write
        movl $1, %ebx       # Đầu ra chuẩn (stdout)
        movl $msg_input, %ecx  # Địa chỉ của chuỗi msg_input
        movl $len, %edx     # Độ dài của chuỗi msg_input
        int $0x80           # Gọi hệ thống kernel để in chuỗi

        # Đọc số từ bàn phím vào biến num4
        movl $3, %eax       # Số gọi hệ thống cho syscall read
        movl $0, %ebx       # Đầu vào chuẩn (stdin)
        movl $num4, %ecx    # Địa chỉ của biến num4
        movl $3, %edx       # Độ dài tối đa được đọc 
        int $0x80           # Gọi hệ thống kernel để đọc dữ liệu

        # Tính toán trung bình của 4 số
        movl num1, %ebx     # Load giá trị của num1 vào thanh ghi %ebx, giá trị của num1 sẽ lưu vào %bl (byte thấp nhất) vì chỉ chiếm 1 byte (tương tự với num2, num3 và num4)
        subb $48, %bl       # Chuyển đổi ký tự số thành giá trị số
        movl num2, %ecx     # Load giá trị của num2 vào thanh ghi %ecx
        subb $48, %cl       # Chuyển đổi ký tự số thành giá trị số
        addb %cl, %bl       # Cộng giá trị của num2 vào giá trị của thanh ghi %bl, ta được tổng của 2 số
        movl num3, %ecx     # Load giá trị của num3 vào thanh ghi %ecx
        subb $48, %cl       # Chuyển đổi ký tự số thành giá trị số
        addb %cl, %bl       # Cộng giá trị của num3 vào giá trị của thanh ghi %bl, ta được tổng của 3 số
        movl num4, %ecx     # Load giá trị của num4 vào thanh ghi %ecx
        subb $48, %cl       # Chuyển đổi ký tự số thành giá trị số
        addb %cl, %bl       # Cộng giá trị của num4 vào giá trị của thanh ghi %bl, ta được tổng của 4 số
        movb %bl, avg       # Lưu giá trị của tổng của 4 số vào biến avg

        # Kiểm tra xem các số có phải là 10 hay không và cộng 9 vào avg nếu phải
        movl $num1, %esi   # Load địa chỉ của num1 vào thanh ghi %esi
        movb 1(%esi), %bl  # Lấy ký tự thứ hai từ num1 và đặt vào thanh ghi %bl
        cmp $48, %bl       # So sánh với ký tự '0'
        jne num1_not10     # Nếu không phải là '0', nhảy tới nhãn num1_not10
        addb $9, avg       # Cộng 9 vào avg nếu là '0', vì nếu num1 là 10 thì chỉ cộng 1 vào tổng.
num1_not10:
        # Lặp lại quá trình kiểm tra và cộng 9 cho các số còn lại (num2, num3, num4)
        movl $num2, %esi   
        movb 1(%esi), %bl  
        cmp $48, %bl       
        jne num2_not10     
        addb $9, avg       
num2_not10:
        movl $num3, %esi   
        movb 1(%esi), %bl  
        cmp $48, %bl       
        jne num3_not10     
        addb $9, avg       
num3_not10:
        movl $num4, %esi   
        movb 1(%esi), %bl  
        cmp $48, %bl       
        jne done           
        addb $9, avg       
done:
        # Chia avg cho 4 bằng cách dịch phải 2 bit (tương đương với chia cho 4)
        sarb $2, avg
        # Chuyển giá trị của avg từ dạng số nguyên sang ký tự ASCII tương ứng
        addb $48, avg
        #Kiểm tra avg có bằng 10 không (bằng ký tự ':' trong ASCII)
        movl $avg, %esi         # Load giá trị của biến avg vào thanh ghi %esi
        movb 0(%esi), %bl       # Load byte đầu tiên của avg vào thanh ghi %bl
        cmp $58, %bl            # So sánh giá trị của %bl với '58' (trong ASCII là ':')
        jne avg_not_equal_10    # Nếu không bằng '58', nhảy đến nhãn avg_not_equal_10
        xorl %ebx, %ebx         # Nếu bằng '58', thực hiện đặt giá trị của biến avg về 10 (ASCII của ký tự '1' là 49, '0' là 48)
        movb $49, %bl
        movb $48, %bh
        movl %ebx, avg
    #
avg_not_equal_10:
        # In giá trị trung bình ra màn hình
        movl $4, %eax       # Số gọi hệ thống cho syscall write
        movl $1, %ebx       # Đầu ra chuẩn (stdout)
        movl $avg, %ecx     # Địa chỉ của biến avg
        movl $3, %edx       # Độ dài của giá trị trung bình 
        int $0x80           # Gọi hệ thống kernel để in giá trị trung bình

        # In ký tự xuống dòng
        movl $4, %eax       # Số gọi hệ thống cho syscall write
        movl $1, %ebx       # Đầu ra chuẩn (stdout)
        movl $newline, %ecx # Địa chỉ của chuỗi newline
        movl $2, %edx       # Độ dài của chuỗi newline 
        int $0x80           # Gọi hệ thống kernel để in ký tự xuống dòng

        # Thoát chương trình
        movl $1, %eax       # Số gọi hệ thống cho syscall exit
        int $0x80           # Gọi hệ thống kernel để thoát chương trình
