`timescale 1ns / 1ps

module tb_vga_pic;

    // Testbench signals
    reg vga_clk;
    reg sys_rst_n;
    reg [9:0] pix_x;
    reg [9:0] pix_y;
    wire [15:0] pix_data;

    // Instantiate the VGA picture module
    vga_pic uut (
        .vga_clk(vga_clk),
        .sys_rst_n(sys_rst_n),
        .pix_x(pix_x),
        .pix_y(pix_y),
        .pix_data(pix_data)
    );

    // Clock generation
    initial begin
        vga_clk = 0;
        forever #20 vga_clk = ~vga_clk; // 25MHz clock period (40ns)
    end

    // Test sequence
    initial begin
        // Initialize signals
        sys_rst_n = 0;
        pix_x = 0;
        pix_y = 0;

        // Apply reset
        #100;
        sys_rst_n = 1;

        // Test different pixel coordinates
        #100;
        pix_x = 260; pix_y = 100; // Inside character area
        #40;
        pix_x = 300; pix_y = 150; // Inside character area
        #40;
        pix_x = 100; pix_y = 300; // Outside character area
        #40;
        pix_x = 400; pix_y = 200; // Outside character area
        #40;

        // Finish simulation
        #500;
        $stop;
    end

endmodule
