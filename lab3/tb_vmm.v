`timescale 1ns/1ps

module tb_vmm;

reg sys_clk;
reg sys_rst_n;
reg coin1;
reg coin05;
reg refun;
wire ref05;
wire doref;
wire cola;

vmm vmtb (
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .coin1(coin1),
    .coin05(coin05),
    .refun(refun),
    .ref05(ref05),
    .doref(doref),
    .cola(cola)
);


initial begin
    sys_clk = 0;
    forever #5 sys_clk = ~sys_clk;
end


initial begin
    sys_rst_n = 0;
    coin1 = 1;
    coin05 = 1;
    refun = 1;

    #10;
    sys_rst_n = 1;

    #10;
    coin05 = 0; 
    #10;
    coin05 = 1;

    #10;

    #10;
    coin1 = 0; 
    #10;
    coin1 = 1;

    #10;


    #10;
    refun = 0; 
    #10;
    refun = 1;

    #10;

    #10;
    coin05 = 0;
    #10;
    coin05 = 1;
    #10;
    coin1 = 0;
    #10;
    coin1 = 1;
    #10;
    coin05 = 0;
    #10;
    coin05 = 1;

    #10;
    if (cola != 0) $display("Test failed: Expected cola output after 1.5 yuan");

    #100;
    $stop;
end

endmodule
