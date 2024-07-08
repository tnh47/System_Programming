.section .data
msg_input:
        .string "Enter a number (5 digits): "   # Chuỗi để yêu cầu nhập số
        len = . -msg_input                      # Độ dài của chuỗi msg_input
msg_ouput1:
        .string "Doi xung"  
        len1 = . -msg_ouput1                    # Độ dài của chuỗi msg_ouput1
msg_ouput2:
        .string "Khong doi xung"   
        len2 = . -msg_ouput2                    # Độ dài của chuỗi msg_ouput2
newline:
        .string "\n"                            # Chuỗi xuống dòng

.section .bss
        .lcomm num, 6                           # Khai báo biến num có độ dài bằng 6 bytes

.section .text        
.globl _start
_start:
        # In chuỗi yêu cầu nhập số
        movl $4, %eax           
        movl $1, %ebx          
        movl $msg_input, %ecx   
        movl $len, %edx         
        int $0x80               
        # Đọc số từ bàn phím vào biến num
        movl $3, %eax           
        movl $0, %ebx          
        movl $num, %ecx        
        movl $6, %edx           
        int $0x80               

        movl $num, %eax         # Gán biến num vào thanh ghi eax
        mov 0(%eax), %bl        # Lưu giá trị của phần tử thứ 1 trong thanh ghi eax vào thanh ghi bl
        mov 1(%eax), %bh        # Lưu giá trị của phần tử thứ 2 trong thanh ghi eax vào thanh ghi bh    
        mov 3(%eax), %cl        # Lưu giá trị của phần tử thứ 4 trong thanh ghi eax vào thanh ghi cl
        mov 4(%eax), %ch        # Lưu giá trị của phần tử thứ 5 trong thanh ghi eax vào thanh ghi ch
        cmpb %bl, %ch           # So sánh thanh ghi bl và thanh ghi ch
        je so1_bang_so5         # Nếu thanh ghi bl bằng thanh ghi ch thì nhảy đến nhãn so1_bang_so5 
        jmp khong_doi_xung      # Nếu thanh ghi bl không bằng thanh ghi ch thì nhảy đến nhãn khong_doi_xung  
so1_bang_so5:
        cmpb %bh, %cl           # So sánh thanh ghi bh và thanh ghi cl
        je so2_bang_so4         # Nếu thanh ghi bh bằng thanh ghi cl thì nhảy đến nhãn so2_bang_so4  
        jmp khong_doi_xung      # Nếu thanh ghi bh không bằng thanh ghi cl thì nhảy đến nhãn khong_doi_xung
so2_bang_so4:
        # In ra thông báo dãy số đối xứng
        movl $4, %eax            
        movl $1, %ebx           
        movl $msg_ouput1, %ecx  
        movl $len1, %edx        
        int $0x80               
        jmp done
khong_doi_xung:
        # In ra thông báo dãy số không đối xứng
        movl $4, %eax           
        movl $1, %ebx           
        movl $msg_ouput2, %ecx  
        movl $len2, %edx        
        int $0x80               
done:
        # In ký tự xuống dòng
        movl $4, %eax           
        movl $1, %ebx           
        movl $newline, %ecx     
        movl $2, %edx           
        int $0x80               
        # Thoát chương trình
        movl $1, %eax           
        int $0x80               
