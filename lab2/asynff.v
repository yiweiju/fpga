module asynff (
input wire sys_clk , //Clock input. we Will use system clock, 50M Hz
input wire sys_rst_n, //Reset button
input wire key_in , //Input button

output reg led_out //Output
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