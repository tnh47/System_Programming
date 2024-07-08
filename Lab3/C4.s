.section .data
msg_input:
        .string "Nhap nam sinh (4 chu so): "   # Chuỗi để yêu cầu nhập số
        len = . - msg_input             # Độ dài của chuỗi msg_input
newline:
        .string "\n"                   # Chuỗi xuống dòng
msg_output1:
        .string "Can be in HCM Communist Youth Union"  
        len1 = . -msg_output1             # Độ dài của chuỗi msg_output1
msg_output2:
        .string "Can't be in HCM Communist Youth Union"   
        len2 = . -msg_output2            # Độ dài của chuỗi msg_output2
msg_output3:
        .string "Tuoi: "   
        len3 = . -msg_output3            # Độ dài của chuỗi msg_output2

.section .bss
        .lcomm year_birth, 5
        .lcomm age, 5
        .lcomm age2, 5
.section .text        
.globl _start
_start:
        # In chuỗi yêu cầu nhập số
        movl $4, %eax       
        movl $1, %ebx       
        movl $msg_input, %ecx  
        movl $len, %edx     
        int $0x80          
        # Đọc chuỗi từ bàn phím
        movl $3, %eax       
        movl $0, %ebx       
        movl $year_birth, %ecx   
        movl $5, %edx       
        int $0x80           
        # Xóa các thanh ghi để sử dụng lại
        xorl %eax, %eax
        xorl %ebx, %ebx
        xorl %ecx, %ecx
        xorl %edx, %edx
        # Chuyển đổi chuỗi thành số nguyên
        movl $year_birth, %esi
        mov 0(%esi), %dl        # Lấy ký tự đầu tiên từ chuỗi
        mov 1(%esi), %cl        # Lấy ký tự thứ hai từ chuỗi
        mov 2(%esi), %bl        # Lấy ký tự thứ ba từ chuỗi
        mov 3(%esi), %al        # Lấy ký tự cuối cùng từ chuỗi
        sub $'0', %dl           # Chuyển ký tự số thành giá trị số
        sub $'0', %cl           # Chuyển ký tự số thành giá trị số
        sub $'0', %bl           # Chuyển ký tự số thành giá trị số
        sub $'0', %al           # Chuyển ký tự số thành giá trị số
        imull $1000, %edx       # Nhân giá trị số đầu tiên với 1000
        imull $100, %ecx        # Nhân giá trị số thứ hai với 100
        imull $10, %ebx         # Nhân giá trị số thứ ba với 10
        addl %ebx, %eax         # Cộng giá trị số cuối cùng vào tổng
        addl %ecx, %eax         # Cộng giá trị số thứ ba vào tổng
        addl %edx, %eax         # Cộng giá trị số thứ hai vào tổng
        # Tính tuổi
        movl $2024, %esi       # Năm hiện tại
        sub %eax, %esi         # Lấy năm hiện tại trừ đi năm sinh để tính tuổi
        movl %esi, age         # Lưu tuổi vào biến age
        movl %esi, age2         # Lưu tuổi vào biến age2
        # In "Tuoi: "
        movl $4, %eax          
        movl $1, %ebx          
        movl $msg_output3, %ecx   
        movl $len3, %edx       
        int $0x80
split:
        # Chia tuổi thành các chữ số và chuyển chúng thành ký tự
        movl age, %eax          # Di chuyển tuổi vào thanh ghi %eax
        movl $10, %ebx          # Chuẩn bị cho việc chia cho 10

        movl $0, %edi           # Thiết lập đếm từ 0 tới 3 (index cho mảng age)
divide_loop:
        xorl %edx, %edx         # Xóa %edx để chuẩn bị cho phép chia
        div %ebx                # Chia %eax cho 10, thương sẽ lưu trong %eax, số dư trong %edx
        add $48, %dl            # Chuyển số dư thành mã ASCII
        mov %dl, age(%edi)      # Lưu ký tự ASCII vào mảng age
        inc %edi                # Tăng chỉ số mảng
        test %eax, %eax         # Kiểm tra xem đã chia hết chưa
        jnz divide_loop         # Nếu chưa, lặp lại
        # Đảo ngược chuỗi age
        movl $0, %edi           # Reset %edi thành 0 (đếm từ 0 tới 3)
        movl $3, %esi           # Đặt %esi là 3 (index cho mảng age)
swap_loop:
        movl age(%edi), %eax    # Load ký tự từ mảng age
        movl age(%esi), %ebx    # Load ký tự từ mảng age ngược
        mov age(%edi), %dl      # Lưu ký tự từ mảng age vào %dl
        mov age(%esi), %dh      # Lưu ký tự từ mảng age ngược vào %dh
        mov %dh, age(%edi)      # Gán ký tự từ mảng age ngược vào mảng age
        mov %dl, age(%esi)      # Gán ký tự từ mảng age vào mảng age ngược
        inc %edi                # Tăng chỉ số mảng age
        dec %esi                # Giảm chỉ số mảng age ngược
        cmp %edi, %esi          # So sánh chỉ số %edi và %esi
        jg swap_loop            # Nếu %edi < %esi, tiếp tục vòng lặp
        # In tuổi đã đảo ngược
        movl $4, %eax        
        movl $1, %ebx        
        lea age, %ecx       
        movl $4, %edx        
        int $0x80    
print_output:       
        # So sánh tuổi để in ra thông báo phù hợp
        cmpl $16, age2
        jge greater_than_16
        jmp else_condition
greater_than_16:
        cmpl $30, age2
        jle greater_than_16_and_less_than_30
        jmp else_condition
greater_than_16_and_less_than_30:
        # In ký tự xuống dòng
        movl $4, %eax        
        movl $1, %ebx        
        movl $newline, %ecx  
        movl $1, %edx        
        int $0x80            
        # In thông báo "Can be in HCM Communist Youth Union"
        movl $4, %eax 
        movl $1, %ebx       
        movl $msg_output1, %ecx  
        movl $len1, %edx    
        int $0x80           
        jmp done
else_condition:
        # In ký tự xuống dòng
        movl $4, %eax        
        movl $1, %ebx        
        movl $newline, %ecx  
        movl $1, %edx        
        int $0x80
        # In thông báo "Can't be in HCM Communist Youth Union"
        movl $4, %eax      
        movl $1, %ebx       
        movl $msg_output2, %ecx  
        movl $len2, %edx     
        int $0x80           
done: 
        # In ký tự xuống dòng
        movl $4, %eax         
        movl $1, %ebx        
        movl $newline, %ecx  
        movl $1, %edx        
        int $0x80            
        # Thoát chương trình
        movl $1, %eax        
        int $0x80
