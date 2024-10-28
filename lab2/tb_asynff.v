`timescale 1ns/1ns

module tb_asynff;

reg sys_clk;
reg sys_rst_n;
reg key_in;
wire led_out;
asynff uut (
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .key_in(key_in),
    .led_out(led_out)
);


initial begin
    sys_clk = 0;
    forever #10 sys_clk = ~sys_clk; 
end


initial begin
    
    sys_rst_n = 0; 
    key_in = 0;

    #20;
    sys_rst_n = 1; 

    #30 key_in = 1; 
    #40 key_in = 0; 
    #30 key_in = 1;
    #40 key_in = 0; 

    #100;
    $stop;
end

initial begin
    $monitor("Time=%0t ns, sys_rst_n=%b, key_in=%b, led_out=%b", 
              $time, sys_rst_n, key_in, led_out);
end

endmodule
