module Game_Start(
    input         vga_clk_25,       
    input         rst_n,           
    input  [ 9:0] pixel_xpos,      
    input  [ 9:0] pixel_ypos,      
    
    output [15:0] pixel_data     
);


parameter   H_DISP  = 10'd640;          
parameter   V_DISP  = 10'd480;          

localparam  START_X = 10'd267;          
localparam  START_Y = 10'd126;          
localparam  PHOTO_H = 10'd128;          
localparam  PHOTO_V = 10'd128;          
localparam  PHOTO   = 16'd16384;        

localparam  WHITE  = 16'hFFFF;  
localparam  BLANK  = 16'h0000;  
localparam  RED    = 16'hF100;  
localparam  GREEN  = 16'h0400;  
localparam  BLUE   = 16'h001F;  
localparam  YELLOW = 16'hFFE0;  
localparam  PURPLE = 16'h8010;  
localparam  BROWN  = 16'hE618;  


reg  [16:0] rom_addr;    
reg         rom_valid;  

wire [15:0] rom_data;    
wire        rom_rd_en;   




pic_rom	u_pic_rom(
    .clock      (vga_clk_25),
	.address    (rom_addr  ),   
	.rden       (rom_rd_en ),   
    
	.q          (rom_data  )    
);


assign rom_rd_en = ( ((pixel_xpos >= START_X) && (pixel_xpos < START_X + PHOTO_H))
                   && ((pixel_ypos >= START_Y) && (pixel_ypos < START_Y + PHOTO_V)) )
                   ? 1'b1 : 1'b0;
                   

assign pixel_data = rom_valid ? rom_data : WHITE;


always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n)
        rom_addr <= 16'd0;
    else begin
        if(rom_rd_en) begin
            if(rom_addr == PHOTO - 1'b1)
                rom_addr <= 16'd0;              
            else    
                rom_addr <= rom_addr + 16'd1;   
        end
        else 
            rom_addr <= rom_addr;
    end
end


always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n)
        rom_valid <= 1'b0;
    else 
        rom_valid <= rom_rd_en;
end

endmodule 