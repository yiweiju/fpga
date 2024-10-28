`timescale 1ns/1ns

module tb_rl;

reg clk;
reg res;
wire [3:0] led;

rl uut (
    .clk(clk),
    .res(res),
    .led(led)
);

initial begin
    clk = 0;
    forever #10 clk = ~clk; 
end


initial begin
    res = 0;
    #20 res = 1; 
end


initial begin
    $monitor("Time=%0t ns, res=%b, led=%b", $time, res, led);
    #1000000; 
    $stop;
end

endmodule
