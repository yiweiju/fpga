module tb_decoder;

reg [1:0] inp;
reg En;
wire [3:0] opt;

decoder uut (
    .key(inp),
    .En(En),
    .opt(opt)
);

initial begin
    $monitor("Time: %0t | key = %b | out = %b | En = %b", $time, inp, opt, En);
    $dumpfile("out.vcd");
    $dumpvars;

    En = 1'b1;
    inp = 2'b00;
    #10;
    inp = 2'b01;
    #10;
    inp = 2'b10;
    #10;
    inp = 2'b11;
    #10;

    En = 1'b0;
    inp = 2'b00;
    #10;
    inp = 2'b01;
    #10;
    inp = 2'b10;
    #10;
    inp = 2'b11;
    #10;

    $stop;
end
    
endmodule