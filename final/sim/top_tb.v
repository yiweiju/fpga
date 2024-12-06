`timescale 1ns/1ns

module top_tb();

reg              sys_clk_50;
reg              sys_rst_n;
reg     [3:0]    key;       

wire    [15:0]   vga_rgb;   
wire             vga_hs;      
wire             vga_vs;      
wire             vga_blank;

initial 
    begin
        sys_clk_50 = 1'b0;
        sys_rst_n  = 1'b0;
        key        = 4'b0000;
        #40
        sys_rst_n  = 1'b1;
        key        = 4'b0001;
        #5
        key        = 4'b0010;
        #2
        key        =4'b0001;
        #2
        key         =4'b0010;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
        #5
        key        = 4'b0010;
        #5
        key        =4'b1000;
        #5
        key         =4'b0100;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
        #5
        key        =4'b1000;
        #5
        key         =4'b0100;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
        #5
        key        =4'b1000;
        #5
        key         =4'b0100;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
        #5
        key        =4'b1000;
        #5
        key         =4'b0100;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
        #5
        key        =4'b1000;
        #5
        key         =4'b0100;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
        #5
        key        =4'b1000;
        #5
        key         =4'b0100;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
        #5
        key        =4'b1000;
        #5
        key         =4'b0100;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
        #5
        key        =4'b1000;
        #5
        key         =4'b0100;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
        #5
        key        =4'b1000;
        #5
        key         =4'b0100;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
        #5
        key        =4'b1000;
        #5
        key         =4'b0100;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
        #5
        key        =4'b1000;
        #5
        key         =4'b0100;
        #5
        key         =4'b0001;
        #5
        key         =4'b0010;
    end

always #2 sys_clk_50 = ~sys_clk_50;

/* always@(posedge sys_clk_50 or negedge sys_rst_n)
    if  (~sys_rst_n)
        begin
            key    = 4'b1000;
        end
    else if(key == 4'b0000)
        begin
            key    = 4'b1000;
        end
    else if(key == 4'b0010)
        begin
            key    <= 4'b0001;
        end
    else 
        begin
            key    = key >> 1;
        end */
        
Top_VGA_Game_Snake     trial_inst
(
    .sys_clk_50(sys_clk_50),
    .sys_rst_n (sys_rst_n ),
    .key       (key       ),
    .vga_rgb   (vga_rgb   ),
    .vga_hs    (vga_hs    ),
    .vga_vs    (vga_vs    ),
    .vga_blank (vga_blank )
);

endmodule