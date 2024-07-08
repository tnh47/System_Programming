.section .data
msg_input:
        .string "Nhập vào 1 chuỗi (<255 kí tự): "  
        len = . -msg_input  
msg_output:
        .string "Chuỗi đã chuẩn hóa: "  
        len1 = . -msg_output           
.section .bss
    input:  .space 255
.section .text
.globl _start
_start:
        # In ra yêu cầu nhập chuỗi
        movl $4, %eax              
        movl $1, %ebx              
        movl $msg_input, %ecx       
        movl $len, %edx             
        int $0x80                   

        # Đọc số từ bàn phím vào biến input
        movl $3, %eax               
        movl $0, %ebx               
        movl $input, %ecx          
        movl $255, %edx             
        int $0x80                   

        mov $0, %esi                # Gán giá trị 0 cho thanh ghi esi
        mov $input, %edi            # Đặt địa chỉ của chuỗi nhập vào vào edi

        # Xử lý kí tự đầu tiên
        movb input(%esi), %al        # Gán giá trị của kí tự đầu tiên của biến input vào thanh ghi al              
        cmp $'a', %al                # So sánh ký tự với 'a'
        jl skip_normalize            # Bỏ qua nếu ký tự nhỏ hơn 'a'

        cmp $'z', %al                # So sánh ký tự với 'z'
        jg skip_normalize            # Bỏ qua nếu ký tự lớn hơn 'z'

        sub $32, %al                 # Chuyển đổi ký tự thường thành ký tự hoa
        jmp skip_normalize           # Nhảy đến nhãn skip_normalize 

        # xử lý các kí tự còn lại
normalize:
        movb input(%esi), %al
        cmp $'A', %al               # So sánh ký tự với 'a'
        jl skip_normalize           # Bỏ qua nếu ký tự nhỏ hơn 'a'

        cmp $'Z', %al               # So sánh ký tự với 'z'
        jg skip_normalize           # Bỏ qua nếu ký tự lớn hơn 'z'

        add $32, %al                # Chuyển đổi ký tự thường thành ký tự hoa
skip_normalize:
        movb %al, input(%esi)       # Ghi ký tự vào vị trí cũ
        inc %esi                    # Tăng con trỏ chuỗi
        cmp $10, %al                # Kiểm tra kết thúc chuỗi
        jz end_normalize            # Nếu kết thúc, thoát khỏi vòng lặp
        jmp normalize               # Tiếp tục vòng lặp
        # In ra chuỗi đã chuẩn hóa:
end_normalize:
        # In ra thông báo chuỗi đã chuẩn hóa
        movl $4, %eax               
        movl $1, %ebx               
        movl $msg_output, %ecx      
        movl $len1, %edx            
        int $0x80                   
        # In ra chuỗi đã chuẩn hóa
        mov $4, %eax                
        mov $1, %ebx                
        mov $input, %ecx            
        mov $255, %edx              
        int $0x80                   

        # Kết thúc chương trình
        movl $1, %eax               
        int $0x80                   
        