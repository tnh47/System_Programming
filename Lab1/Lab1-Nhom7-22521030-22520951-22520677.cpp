#include <stdio.h>

void PrintBits(unsigned int x)
{
	int i;
	for (i = 8 * sizeof(x) - 1; i >= 0; i--)
	{
		(x & (1 << i)) ? putchar('1') : putchar('0');
	}
	printf("\n");
}
void PrintBitsOfByte(unsigned int x)
{
	int i;
	for (i = 7; i >= 0; i--)
	{
		(x & (1 << i)) ? putchar('1') : putchar('0');
	}
	printf("\n");
}

// 1.1
int bitAnd(int x, int y)
{
	//PrintBits(x);
	//PrintBits(y);
	return ~(~x | ~y);
}

// 1.2
int negative(int x)
{   
 
    return ~x + 1 ; // Sử dụng phép toán bù 2 bằng cách đảo ngược bit và cộng 1
}

// 1.3
int getByte(int x, int n)
{
	return (x >> (n << 3)) & 0xff; //Dịch phải x đi n * 8 bit để đưa byte thứ n về vị trí đầu tiên, sau đó and với 0xFF để chỉ lấy byte cuối cùng.
}

// 1.4
int getnbit(int x, int n)
{
    
	return x & (~(0xFFFFFFFF << n)); //Tạo ra một mask với n bit bên phải nhất là 1 và các bit còn lại là 0, sau đó and với x để lấy ra các bit bên phải nhất của x 
}

// 1.5
int mulpw2(int x, int n)
{
    //Số dương
    int shift_left = (x << n) & (~((n >> 31)));
    //Số âm
    int shift_right = (x >> (~n + 1)) & (~((n >> 31) & 1) + 1);
    return  shift_left | shift_right;
/* 
* int shift_left = (x << n) & (~((n >> 31)));`: Đây là phần tính toán cho trường hợp `x` là số dương. 
   - `x << n` thực hiện phép dịch trái của `x` đi `n` bit, tương đương với việc nhân `x` cho `2^n`.
   - `~((n >> 31))` thực hiện dịch bit sang phải 31 bit của `n`, nếu `n` là số dương thì `~((n >> 31))` sẽ là 0xFFFFFFFF, và nếu `n` là số âm thì `~((n >> 31))` sẽ là 0x00000000. 
   - Thực hiện phép AND giữa `x << n` và `~((n >> 31))`, loại bỏ trường hợp `n` là số âm.

3. `int shift_right = (x >> (~n + 1)) & (~((n >> 31) & 1) + 1);`: Đây là phần tính toán cho trường hợp `x` là số âm.
   - `(~n + 1)` thực hiện việc chuyển `n` thành số dương.
   - `(x >> (~n + 1))` thực hiện dịch phải `x` đi `-n` bit, tương đương với việc chia `x` cho `2^n`.
   - `((n >> 31) & 1)` được sử dụng để xác định xem `n` có âm hay không, nếu `n` là số dương thì kết quả sẽ là 0, và ngược lại.
   - `(~((n >> 31) & 1) + 1)` sẽ trả về 0xFFFFFFFF nếu `n` là số âm và 0x00000000 nếu `n` là số dương.
   - Thực hiện phép AND giữa `x >> (~n + 1)` và `(~((n >> 31) & 1) + 1)`, loại bỏ trường hợp `n` là số dương.

4. `return shift_left | shift_right;`: Hàm trả về kết quả của phép nhân `x` cho `2^n` đối với `n` là số dương, phép chia `x` cho `2^n` đối với `n` là số âm.*/
}



// 2.1
int isSameSign(int x, int y)
{
	return !((x ^ y) >> 31);
}
/*
x ^ y: Phép XOR giữa x và y trả về một số mà bit 1 chỉ xuất hiện ở các vị trí mà x và y khác dấu.

(x ^ y) >> 31: Dịch phải 31 bit của kết quả phép XOR, lấy bit dấu của kết quả.

!((x ^ y) >> 31): Trả về true nếu bit dấu của x và y giống nhau (cùng dấu), và trả về false nếu bit dấu của chúng khác nhau (khác dấu).
*/
// 2.2
int is8x(int x)
{
	return !(x & 7);
}
/*
x & 7: Phép AND giữa x và 7, số 7 là 111 (3 bits cuối cùng là 1). Nếu tất cả ba bit cuối cùng của x đều là 0, tức là số đó chia hết cho 8.

!(x & 7): Nếu tất cả ba bit cuối cùng của x đều là 0, thì kết quả của phép AND là 0 và hàm trả về true. Ngược lại, nếu ít nhất một trong ba bit cuối cùng của x là 1, thì kết quả của phép AND là khác 0 và hàm trả về false.
*/
// 2.3
int isPositive(int x)
{
    return !((x >> 31)) & !!x;
}
/*
x >> 31: Trích xuất bit dấu của số nguyên x. Bit dấu là bit cuối cùng sau khi dịch phải 31 bit. Nếu x là số dương, bit dấu sẽ là 0; nếu x là số âm, bit dấu sẽ là 1.

!(x >> 31): Trả về 1 (true) nếu bit dấu là 0, tức là x là số dương hoặc 0. Nếu bit dấu là 1, tức là x là số âm, kết quả sẽ là 0 (false).

!!x: Nếu x khác 0, kết quả sẽ là 1; nếu x bằng 0, kết quả sẽ là 0. Nói cách khác, nếu x khác 0, kết quả sẽ là true; nếu x bằng 0, kết quả sẽ là false.

!(x >> 31) & !!x: Kết quả cuối cùng sẽ là 1 (true) nếu x là số dương hoặc 0, và là 0 (false) nếu x là số âm hoặc 0.
*/
// 2.4
int isLess2n(int x, int y)
{
	return !(x & (~(1 << y) + 1));
}
/*
1 << y: tính toán giá trị của 2^y bằng cách dịch trái số 1 y lần.

~(1 << y) + 1:  tạo ra một số âm có bit 1 từ bit MSB đến vị trí y và bit 0 ở tất cả các vị trí còn lại

x & (~(1 << y) + 1): Phép AND này sẽ kiểm tra xem bit thứ y của số x có bằng 0 hay không. Nếu x nhỏ hơn 2^y
 , thì bit tương ứng của x sẽ bằng 0, và kết quả của phép AND sẽ là 0.

!(x & (~(1 << y) + 1)): Toán tử ! được sử dụng để đảo ngược kết quả của phép AND. Nếu bit thứ y của x bằng 0, kết quả sẽ là true, ngược lại kết quả sẽ là false.
*/
int main()
{
	int score = 0;
	printf("Your evaluation result:");
	printf("\n1.1 bitAnd");
	if (bitAnd(3, -9) == (3 & -9))
	{
		printf("\tPass.");
		score += 1;
	}
	else
		printf("\tFailed.");

	printf("\n1.2 negative");
	if (negative(0) == 0 && negative(9) == -9 && negative(-5) == 5)
	{
		printf("\tPass.");
		score += 1;
	}
	else
		printf("\tFailed.");

	//1.3
	printf("\n1.3 getByte");
	if (getByte(8, 0) == 8 && getByte(0x11223344, 1) == 0x33)
	{
		printf("\tPass.");
		score += 2;
	}
	else
		printf("\tFailed.");

	printf("\n1.4 getnbit");
	if (getnbit(0, 0) == 0 && getnbit(31, 3) == 7 && getnbit(16, 4) == 0)
	{
		printf("\tPass.");
		score += 3;
	}
	else
		printf("\tFailed.");
	//1.5
	printf("\n1.5 mulpw2");
	if (mulpw2(10, -1) == 5 && mulpw2(15, -2) == 3 && mulpw2(32, -4) == 2)
	{
		if (mulpw2(10, 1) == 20 && mulpw2(50, 2) == 200)
		{
			printf("\tAdvanced Pass.");
			score += 4;
		}
		else
		{
			printf("\tPass.");
			score += 3;
		}
	}
	else
		printf("\tFailed.");

	printf("\n2.1 isSameSign");
	if (isSameSign(4, 2) == 1 && isSameSign(13, -4) == 0 && isSameSign(0, 10) == 1)
	{
		printf("\tPass.");
		score += 2;
	}
	else
		printf("\tFailed.");

	printf("\n2.2 is8x");
	if (is8x(16) == 1 && is8x(3) == 0 && is8x(0) == 1)
	{
		printf("\tPass.");
		score += 2;
	}
	else
		printf("\tFailed.");

	printf("\n2.3 isPositive");
	if (isPositive(10) == 1 && isPositive(-5) == 0 && isPositive(0) == 0)
	{
		printf("\tPass.");
		score += 3;
	}
	else
		printf("\tFailed.");

	printf("\n2.4 isLess2n");
	if (isLess2n(12, 4) == 1 && isLess2n(8, 3) == 0 && isLess2n(15, 2) == 0)
	{
		printf("\tPass.");
		score += 3;
	}
	else
		printf("\tFailed.");

	printf("\n--- FINAL RESULT ---");
	printf("\nScore: %.1f", (float)score / 2);
	if (score < 5)
		printf("\nTrouble when solving these problems? Contact your instructor to get some hints :)");
	else
	{
		if (score < 8)
			printf("\nNice work. But try harder.");
		else
		{
			if (score >= 10)
				printf("\nExcellent. We found a master in bit-wise operations :D");
			else
				printf("\nYou're almost there. Think more carefully in failed problems.");
		}
	}

	printf("\n\n\n");
}