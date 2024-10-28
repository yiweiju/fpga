module testSynff;

reg inp;
wire opt;
reg res;

synff synff_test (
    .inp(inp),
    .opt(opt),
    .res(res)
);

initial begin
        $monitor("Time: %0t | inp = %b  res = %b | opt = %b ", $time, inp,res,opt);
        $dumpfile("out.vcd");
        $dumpvars;

        inp = 1'b1;
        res = 1'b1;
        #10;

        inp = 1'b1;
        res = 1'b0;
        #10;

        inp = 1'b0;
        res = 1'b0;
        #10;

        inp = 1'b1;
        res = 1'b0;
        #10;

        inp = 1'b0;
        res = 1'b1;
        #10;

        inp = 1'b0;
        res = 1'b0;
        #10;

        inp = 1'b0;
        res = 1'b1;
        #10;

    
        $stop;
    
end

endmodule