module asynff (
input wire sys_clk , 
input wire sys_rst_n,
input wire key_in , 

output reg led_out 
 );

 always@(posedge sys_clk or negedge sys_rst_n) begin
 if(sys_rst_n == 1'b0) 
 begin
 led_out <= 1'b0; 
 end
 else
 begin
 led_out <= key_in;
 end
 end


endmodule
