module vga_pic(
input wire vga_clk , //VGA working clock, 25MHz
input wire sys_rst_n , //Reset signal. Low level is effective
input wire [9:0] pix_x , //X coordinate of current pixel
input wire [9:0] pix_y , //Y coordinate of current pixel

output reg [15:0] pix_data //Color information

);

reg [127:0] char [31:0];

parameter BLACK = 16'h0000,
 		  WHITE = 16'hFFFF;

parameter H_VALID = 10'd640 ,
 		  V_VALID = 10'd480 ;

parameter CHAR_H_S = 10'd256 ,
		  CHAR_V_S = 10'd32;

parameter CHAR_H = 10'd192,
		  CHAR_V = 10'd224;


			

always @(posedge vga_clk) begin
char[ 0] <= 128'h00000000000000000000000000000000;
	char[ 1] <= 128'h00000000000000000000000000000000;
	char[ 2] <= 128'h00000000000000000000000000000000;
	char[ 3] <= 128'h00000000000000000000000000000000;
	char[ 4] <= 128'h00000000000000007F00000000000000;
	char[ 5] <= 128'h0000004000004000C1001FFFE0000000;
	char[ 6] <= 128'h000180E0008040018080007000000000;
	char[ 7] <= 128'h000181A0008040010080007000000000;
	char[ 8] <= 128'h00038120008040010000007000000000;
	char[ 9] <= 128'h00028330008040010000007000000000;
	char[10] <= 128'h00024210008040010000007000000000;
	char[11] <= 128'h00044218008040018000007000000000;
	char[12] <= 128'h00044408008040008000007000000000;
	char[13] <= 128'h00082408008040004000007000000000;
	char[14] <= 128'h00082404008060003000007000000000;
	char[15] <= 128'h00103404008060001000007000000000;
	char[16] <= 128'h001018060090A0000800007000000000;
	char[17] <= 128'h003018020083A0040C00007000000000;
	char[18] <= 128'h0020100300C620040600003000000000;
	char[19] <= 128'h00600001005830060200003000000000;
	char[20] <= 128'h00400001006000020200003000000004;
	char[21] <= 128'h00C00000000000030300003000000000;
	char[22] <= 128'h00000044000000018100003000000000;
	char[23] <= 128'h00000000000000008300003000000000;
	char[24] <= 128'h00000000000000007E00003000000000;
	char[25] <= 128'h00000000000000000000003000000000;
	char[26] <= 128'h00000000000000000000003000000000;
	char[27] <= 128'h00000000000000000000001000000000;
	char[28] <= 128'h00000000000000000000001800000000;
	char[29] <= 128'h00000000000000000000001800000000;
	char[30] <= 128'h00000000000000000000000000000000;
	char[31] <= 128'h00000000000000000000000000000000;
end

 always@(posedge vga_clk or negedge sys_rst_n) begin
	if(sys_rst_n == 1'b0)
		pix_data <= 16'd0;
	else if ((pix_x >= (CHAR_H - 1'b1)) && (pix_x < (CHAR_V + CHAR_H_S - 1'b1)) && (pix_y >= CHAR_V) && (pix_y < (CHAR_V + CHAR_V_S)) && (char[pix_y-CHAR_V][H_VALID-pix_x+CHAR_H-1'b1]==1'b1)) 
		begin
			pix_data <= WHITE;
		end
	else
		begin
			pix_data <= BLACK;
		end
 end

 endmodule