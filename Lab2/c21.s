.section .data
str:
        .string "NT109UIT"   # Chuỗi kí tự "NT109UIT"
        len = . -str           # lấy độ dài của chuỗi str
newline:
        .string "\n"            # Chuỗi kí tự xuống dòng

.section .bss
        .lcomm length, 4     # Khai báo một biến có tên là length, kích thước 4 bytes (32-bit)

.section .text
        .global _start         # Đánh dấu điểm bắt đầu thực thi chương trình

_start:
        movl $len, %esi          # Lưu độ dài của chuỗi str vào thanh ghi %esi
        addl $48, %esi           # Chuyển từ ký tự ASCII sang số, vì ASCII '0' có giá trị là 48
        subl $1, %esi            # Trừ 1 giá trị vì độ dài tính null ở cuối chuỗi
        movl %esi, length       # Lưu giá trị số vào biến length 

        movl $1, %edx            # Kích thước chuỗi (1 byte)
        movl $length, %ecx      # Lấy địa chỉ của biến length
        movl $1, %ebx            # Đầu ra chuẩn (stdout)
        movl $4, %eax            # Số gọi hệ thống cho syscall write
        int $0x80                 # Gọi hệ thống kernel

        movl $4, %eax            # Số gọi hệ thống cho syscall write
        movl $1, %ebx            # Đầu ra chuẩn (stdout)
        movl $newline, %ecx    # Địa chỉ của chuỗi newline
        movl $2, %edx           # Kích thước của chuỗi newline
        int $0x80                 # Gọi hệ thống kernel

        movl $1, %eax             # Số gọi hệ thống cho syscall exit
        int $0x80                  # Gọi hệ thống kernel để thoát chương trình
