`timescale 1ns/1ps

module tb_counter;

    // Testbench signals
    reg clk;
    reg res;
    wire opt;

    // Instantiate the counter module
    counter uut (
        .clk(clk),
        .res(res),
        .opt(opt)
    );

    // Clock generation: 10ns period (100 MHz clock)
    always #1 clk = ~clk;

    // Test sequence
    initial begin

        $dumpfile("out.vcd");
        $dumpvars;
        // Initialize signals
        clk = 0;
        res = 0;

        // Apply reset
        $display("Applying reset...");
        res = 1;
        #20; // hold reset for a few cycles
        res = 0;
        $display("Releasing reset...");

        // Observe opt signal and counter behavior
        #100000000; // Simulate for a sufficient time to observe opt toggling

        // End simulation
        $stop;
    end

    // Monitor changes in output for debugging
    initial begin
        $monitor("At time %t, opt = %b", $time, opt);
    end

endmodule