module Game_Speed(
    input            vga_clk_25,       
    input            rst_n,           
    input     [ 9:0] pixel_xpos,       
    input     [ 9:0] pixel_ypos,        
    
    output reg[16:0] pixel_data      
);
 

parameter   H_DISP  = 10'd640;          
parameter   V_DISP  = 10'd480;          

localparam  ROW1_X  = 10'd256;          
localparam  ROW1_Y  = 10'd160;          
localparam  ROW1_H  = 10'd128;          
localparam  ROW1_V  = 10'd32;           

localparam  ROW2_X  = 10'd258;          
localparam  ROW2_Y  = 10'd210;          
localparam  ROW2_H  = 10'd120;          
localparam  ROW2_V  = 10'd24;           

localparam  ROW3_X  = 10'd258;          
localparam  ROW3_Y  = 10'd240;          
localparam  ROW3_H  = 10'd120;          
localparam  ROW3_V  = 10'd24;           

localparam  WHITE  = 16'hFFFF;  
localparam  BLANK  = 16'h0000;  
localparam  RED    = 16'hF800;  
localparam  GREEN  = 16'h0400;  
localparam  BLUE   = 16'h001F;  
localparam  YELLOW = 16'hFFE0;  
localparam  PURPLE = 16'h8010;  
localparam  BROWN  = 16'hE618;  


reg [127:0] row_1 [31:0];   
reg [119:0] row_2 [23:0];   
reg [119:0] row_3 [23:0];   

wire [9:0] x1_cnt;          
wire [9:0] y1_cnt;          
wire [9:0] x2_cnt;          
wire [9:0] y2_cnt;          
wire [9:0] x3_cnt;          
wire [9:0] y3_cnt;          


 

assign x1_cnt = pixel_xpos - ROW1_X;
assign y1_cnt = pixel_ypos - ROW1_Y;
assign x2_cnt = pixel_xpos - ROW2_X;
assign y2_cnt = pixel_ypos - ROW2_Y;
assign x3_cnt = pixel_xpos - ROW3_X;
assign y3_cnt = pixel_ypos - ROW3_Y;


always @(posedge vga_clk_25)
begin
    row_1[0]  <= 128'h00000000000000000000000000000000;
    row_1[1]  <= 128'h00000000000000000000000000000000;
    row_1[2]  <= 128'h00000000000000000000400001800000;
    row_1[3]  <= 128'h000060000001C0000000300000E00000;
    row_1[4]  <= 128'h000030000000E0000000300000E00380;
    row_1[5]  <= 128'h00002000000060000000300000403FC0;
    row_1[6]  <= 128'h0300200000001F00070230000043E380;
    row_1[7]  <= 128'h01C027000001FC000383300000400300;
    row_1[8]  <= 128'h00E1FF00007F00000183300000410600;
    row_1[9]  <= 128'h0067A00000601C0000823F000040CC00;
    row_1[10] <= 128'h00002100006408000006FC0000783800;
    row_1[11] <= 128'h00003FC000460BC00005F00001E03800;
    row_1[12] <= 128'h000FE1800046FF00000430000FC07E00;
    row_1[13] <= 128'h00042180005F980000083FC00040C780;
    row_1[14] <= 128'h0784210000C210000380FE000051B1E0;
    row_1[15] <= 128'h3F867F0000C238000FBF9800006618FC;
    row_1[16] <= 128'h0303E00000C3C0000300D80000C01878;
    row_1[17] <= 128'h0200600000C000000301980001C01F00;
    row_1[18] <= 128'h0200FC0000803C00030198000341FC00;
    row_1[19] <= 128'h0301A7000187DC00030310000E401800;
    row_1[20] <= 128'h010323800184180003021020384018E0;
    row_1[21] <= 128'h01862080010618000106103030407FF0;
    row_1[22] <= 128'h0188200003033000010C1830004FF800;
    row_1[23] <= 128'h013060000201B00001100FF000401800;
    row_1[24] <= 128'h0FE020000600E0000FC003E002C01800;
    row_1[25] <= 128'h3C3E20000400F0003C3E000001C01800;
    row_1[26] <= 128'h0007F80008039C000003F80E01C01800;
    row_1[27] <= 128'h00007FFC100E0F800000FFF800C01800;
    row_1[28] <= 128'h00000FE0203807F800001FE000001800;
    row_1[29] <= 128'h00000100004001FC0000000000000800;
    row_1[30] <= 128'h00000000000000000000000000000800;
    row_1[31] <= 128'h00000000000000000000000000000000;
    
    row_2[0]  <= 120'h000000000000000000000000000000;
    row_2[1]  <= 120'h000000000000000000000000000000;
    row_2[2]  <= 120'h000000000000000000000000000400;
    row_2[3]  <= 120'h001800020180000000060600000600;
    row_2[4]  <= 120'h001800030180000000020600000600;
    row_2[5]  <= 120'h0018000201800000000206000604C0;
    row_2[6]  <= 120'h0018000401F0000000020600033F80;
    row_2[7]  <= 120'h00180005C7B00000000206C0010400;
    row_2[8]  <= 120'h0018000611BC0000000387E00007E0;
    row_2[9]  <= 120'h0018E0087FE000000012FC60007C60;
    row_2[10] <= 120'h001F801191A00000001204400C2440;
    row_2[11] <= 120'h0018001F23C00E00003204403E27C0;
    row_2[12] <= 120'h0018002221800F00003204FC0C3C00;
    row_2[13] <= 120'h00100043A7E006000022FF00080E00;
    row_2[14] <= 120'h0010001E5180000000020600041DC0;
    row_2[15] <= 120'h0010000211F0000000020D00041460;
    row_2[16] <= 120'h001000021700000000020900046420;
    row_2[17] <= 120'h001000023100000000021880048400;
    row_2[18] <= 120'h001FFC0739000E00000610C01F8400;
    row_2[19] <= 120'h3FF8040667000F0000062070307800;
    row_2[20] <= 120'h1000000483E006000006C03C000FFC;
    row_2[21] <= 120'h0000000000FC0000000000000001F0;
    row_2[22] <= 120'h000000000000000000000000000000;
    row_2[23] <= 120'h000000000000000000000000000000;

    row_3[0]  <= 120'h000000000000000000000000000000;
    row_3[1]  <= 120'h000000000000000000000000000000;
    row_3[2]  <= 120'h000000000000000000000000000400;
    row_3[3]  <= 120'h0000000201800000000C01C0000600;
    row_3[4]  <= 120'h0003FC030180000000063EE0000600;
    row_3[5]  <= 120'h01FFDC0201800000000412C00604C0;
    row_3[6]  <= 120'h1F18000401F0000000041CC0033F80;
    row_3[7]  <= 120'h00180005C7B0000000060980010400;
    row_3[8]  <= 120'h0018000611BC000000050E000007E0;
    row_3[9]  <= 120'h001800087FE00000000500E0007C60;
    row_3[10] <= 120'h0018001191A000000024FF300C2440;
    row_3[11] <= 120'h001F801F23C00E00002452203E27C0;
    row_3[12] <= 120'h0019C02221800F0000244BC00C3C00;
    row_3[13] <= 120'h00184043A7E0060000243400080E00;
    row_3[14] <= 120'h0018001E5180000000244380041DC0;
    row_3[15] <= 120'h0018000211F0000000043D80041460;
    row_3[16] <= 120'h001800021700000000040100046420;
    row_3[17] <= 120'h001800023100000000040900048400;
    row_3[18] <= 120'h0018000739000E00000407001F8400;
    row_3[19] <= 120'h0010000667000F0000040700307800;
    row_3[20] <= 120'h0010000483E0060000040DC0000FFC;
    row_3[21] <= 120'h0010000000FC0000000470F00001F0;
    row_3[22] <= 120'h00100000000000000000003C000000;
    row_3[23] <= 120'h000000000000000000000000000000;  
end


always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n)
        pixel_data <= WHITE;
    else begin
        if( ((pixel_xpos >= ROW1_X) && (pixel_xpos < ROW1_X+ROW1_H))
          && ((pixel_ypos >= ROW1_Y) && (pixel_ypos < ROW1_Y+ROW1_V)) ) begin
            if(row_1[y1_cnt][10'd127 - x1_cnt])  
                pixel_data <= BLUE;              
            else
                pixel_data <= WHITE;           
        end 
        else if( ((pixel_xpos >= ROW2_X) && (pixel_xpos < ROW2_X+ROW2_H))
               && ((pixel_ypos >= ROW2_Y) && (pixel_ypos < ROW2_Y+ROW2_V)) ) begin
                   if(row_2[y2_cnt][10'd120 - x2_cnt])  
                       pixel_data <= BLANK;              
                    else
                       pixel_data <= WHITE;           
        end 
        else if( ((pixel_xpos >= ROW3_X) && (pixel_xpos < ROW3_X+ROW3_H))
               && ((pixel_ypos >= ROW3_Y) && (pixel_ypos < ROW3_Y+ROW3_V)) ) begin
                   if(row_3[y3_cnt][10'd120 - x3_cnt])  
                       pixel_data <= BLANK;              
                   else
                       pixel_data <= WHITE;           
        end   
        else
            pixel_data <= WHITE;               
    end
end

endmodule 