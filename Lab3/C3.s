.section .data
input:
        .string "Enter a number (1-digit) " # Chuối nhập vào
        input_len = . - input
output: 
        .string "Min number: "
        output_len = . - output
newline:
        .string "\n"            # Chuỗi xuống dòng
.section .bss
        .lcomm num, 2               # Khai báo biến num có độ dài 2 byte
        .lcomm tmp, 2               # Khai báo biến tmp có độ dài 2 byte
.section .text
        .globl _start
_start:
        movl $0, %edi               # Gán biến đếm edi = 0
        movl $9, tmp                # Gắn biến tạm tmp để so sánh (tmp = 9 tức là max của số có 1 chữ số)
        jmp loop_input              # Lệnh nhảy đến vòng lặp
loop_input:
        # In ra yêu cầu nhập chuỗi
        movl $input_len, %edx       
        movl $input, %ecx           
        movl $1, %ebx               
        movl $4, %eax               
        int $0x80                   

        # Nhập các kí tự từ bàn phím vào biến num
        movl $3, %eax                  
        movl $0, %ebx               
        movl $num, %ecx             
        movl $2, %edx               
        int $0x80                   
        
        # Xử lí biến num
        mov num + 0, %al             # Lưu giá trị num vừa nhập vào %al
        sub $48, %al                 # Chuyển về dạng số
        
        cmp tmp, %al                 # So sánh biến tạm và giá trị của thanh ghi %al
        jge continue                 # Nhảy đến nhãn continue nếu giá trị của %al lớn hơn hoặc bằng biến tmp
        mov %al, tmp                 # Nếu %al bé hơn biến tmp thì gán tmp = %al

continue:
        incl  %edi                  # Tăng thanh ghi edi lên một đơn vị
condition:
        cmp $5, %edi                # So sánh biến đếm edi với 5
        jne loop_input              # Nhảy đến nhãn loop_input nếu edi không bằng 5
        addl $48, tmp               # Chuyển về dạng chuỗi

        # In ra output_string
        movl    $4, %eax            
        movl    $1, %ebx           
        movl    $output, %ecx       
        movl    $output_len, %edx   
        int     $0x80               

        # In ra gia tri min 
        movl    $4, %eax            
        movl    $1, %ebx            
        movl    $tmp, %ecx          
        movl    $2, %edx            
        int     $0x80               
        # In ký tự xuống dòng
        movl $4, %eax               
        movl $1, %ebx               
        movl $newline, %ecx         
        movl $2, %edx               
        int $0x80                   

        # End
        movl $1, %eax               
        int $0x80                  
