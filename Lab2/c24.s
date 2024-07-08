.section .data
newline:
        .string "\n"               # Chuỗi ký tự xuống dòng

.section .bss
        .lcomm inp, 4              # Khai báo biến inp, kích thước 4 bytes 
        .lcomm outp, 4             # Khai báo biến outp, kích thước 4 bytes 

.section .text
.globl _start
_start:
        # Đọc dữ liệu từ bàn phím vào biến inp
        movl $3, %eax                # Số gọi hệ thống cho syscall read
        movl $0, %ebx                # Đầu vào chuẩn (stdin)
        movl $inp, %ecx              # Địa chỉ của biến inp
        movl $4, %edx                # Độ dài tối đa được đọc
        int $0x80                    # Gọi hệ thống kernel để đọc dữ liệu

        # Xử lý dữ liệu: chuyển đổi ký tự in thường thành ký tự in hoa
        movb inp + 0, %cl            # Lấy ký tự đầu tiên từ inp và lưu vào thanh ghi %cl
        subb $32, %cl                # Trừ 32 để chuyển ký tự in thường thành ký tự in hoa
        movb %cl, outp + 0           # Di chuyển ký tự sau khi xử lý vào biến outp

        movb inp + 1, %cl            # Lấy ký tự thứ hai từ inp và lưu vào thanh ghi %cl
        subb $32, %cl                # Trừ 32 để chuyển ký tự in thường thành ký tự in hoa
        movb %cl, outp + 1           # Di chuyển ký tự sau khi xử lý vào biến outp

        movb inp + 2, %cl            # Lấy ký tự thứ ba từ inp và lưu vào thanh ghi %cl
        subb $32, %cl                # Trừ 32 để chuyển ký tự in thường thành ký tự in hoa
        movb %cl, outp + 2           # Di chuyển ký tự sau khi xử lý vào biến outp

        # In dữ liệu đã xử lý ra màn hình
        movl $4, %eax                # Số gọi hệ thống cho syscall write
        movl $1, %ebx                # Đầu ra chuẩn (stdout)
        movl $outp, %ecx             # Địa chỉ của biến outp
        movl $4, %edx                # Độ dài dữ liệu cần in ra màn hình 
        int $0x80                    # Gọi hệ thống kernel để in dữ liệu

        # In ký tự xuống dòng
        movl $4, %eax                # Số gọi hệ thống cho syscall write
        movl $1, %ebx                # Đầu ra chuẩn (stdout)
        movl $newline, %ecx          # Địa chỉ của chuỗi newline
        movl $2, %edx                # Độ dài của chuỗi newline 
        int $0x80                    # Gọi hệ thống kernel để in ký tự xuống dòng

        # Thoát chương trình
        movl $1, %eax                # Số gọi hệ thống cho syscall exit
        int $0x80                    # Gọi hệ thống kernel để thoát chương trình
