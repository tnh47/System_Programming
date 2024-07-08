.section .data
input:
        .string "Date(MMDDYYYY): "   # chuỗi để nhập dữ liệu MMDDYYYY
        len1 = . -input             # Độ dài của chuỗi input
output:
        .string "Date(DDMMYYYY): "  # chuỗi kết quả DDMMYYYY
        len2 = . -output            # Độ dài của chuỗi output
newline:
        .string "\n"            # chuỗi kí tự xuống dòng
.section .bss
        .lcomm inp, 9   # Khai báo một biến inp, kí%ch thước 9 bytes
        .lcomm outp, 9  # Khai báo một biến outp, kí%ch thước 9 bytes

.section .text
.globl _start
_start:

        # In chuỗi input (MMDDYYYY)
        movl $4, %eax        # Số gọi hệ thống  syscall write
        movl $1, %ebx        # Đầu ra chuẩn (stdout)
        movl $input, %ecx   # Địa chỉ của chuỗi input
        movl $len1, %edx    # Độ dài của chuỗi input
        int $0x80             # Gọi hệ thống kernel để in chuỗi

        # Nhập dữ liệu từ bàn phím vào biến inp
        movl $3, %eax        # Số gọi hệ thống  syscall read
        movl $0, %ebx        # Đầu vào chuẩn (stdin)
        movl $inp, %ecx     # Địa chỉ của biến inp
        movl $9, %edx        # Độ dài tối đa được đọc (9 bytes)
        int $0x80             # Gọi hệ thống kernel để đọc dữ liệu

        # Di chuyển dữ liệu vào chuỗi outp theo định dạng DDMMYYYY
        movb inp + 2, %cl   # Lấy ký tự thứ 3 từ inp và đặt vào %cl
        movb inp + 3, %ch   # Lấy ký tự thứ 4 từ inp và đặt vào %ch
        movb %cl, outp + 0     # Di chuyển %cl vào byte đầu tiên của outp
        movb %ch, outp + 1  # Di chuyển %ch vào byte thứ hai của outp

        movb inp + 0, %cl   # Lấy ký tự thứ 1 từ inp và đặt vào %cl
        movb inp + 1, %ch   # Lấy ký tự thứ 2 từ inp và đặt vào %ch
        movb %cl, outp + 2  # Di chuyển %cl vào byte thứ ba của outp
        movb %ch, outp + 3  # Di chuyển %ch vào byte thứ tư của outp

        movb inp + 4,  %cl  # Lấy ký tự thứ 5 từ inp và đặt vào %cl
        movb inp + 5, %ch   # Lấy ký tự thứ 6 từ inp và đặt vào %ch
        movb %cl, outp + 4  # Di chuyển %cl vào byte thứ năm của outp
        movb %ch, outp + 5  # Di chuyển %ch vào byte thứ sáu của outp

        movb inp + 6, %cl   # Lấy ký tự thứ 7 từ inp và đặt vào %cl
        movb inp + 7, %ch   # Lấy ký tự thứ 8 từ inp và đặt vào %ch
        movb %cl, outp + 6  # Di chuyển %cl vào byte thứ bảy của outp
        movb %ch, outp + 7  # Di chuyển %ch vào byte thứ tám của outp

        # In chuỗi output (DDMMYYYY)
        movl $4, %eax       # Số gọi hệ thống  syscall write
        movl $1, %ebx       # Đầu ra chuẩn (stdout)
        movl $output, %ecx  # Địa chỉ của chuỗi output
        movl $len2, %edx    # Độ dài của chuỗi output
        int $0x80            # Gọi hệ thống kernel để in chuỗi

        
        movl $4, %eax       # Số gọi hệ thống  syscall write
        movl $1, %ebx       # Đầu ra chuẩn (stdout)
        movl $outp, %ecx    # Địa chỉ của chuỗi outp
        movl $9, %edx       # Độ dài của chuỗi outp
        int $0x80            # Gọi hệ thống kernel để in chuỗi

        movl $4, %eax            # Số gọi hệ thống  syscall_write
        movl $1, %ebx            # Đầu ra chuẩn (stdout)
        movl $newline, %ecx    # Địa chỉ của chuỗi newline
        movl $2, %edx           # Kí%ch thước của chuỗi newline
        int $0x80                 # Gọi hệ thống kernel
        # Thoát chương trình
        movl $1, %eax       # Số gọi hệ thống cho syscall exit
        int $0x80            # Gọi hệ thống kernel để thoát chương trình
