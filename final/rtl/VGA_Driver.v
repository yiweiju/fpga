module VGA_Driver(
    input         vga_clk_25,   
    input         rst_n,       
    input  [ 3:0] state_m,      
    input  [15:0] data_start,   
    input  [15:0] data_speed,   
    input  [15:0] data_play,    
    input  [15:0] data_end,     
                
    
    output [15:0] vga_rgb,
    output        vga_hs,     
    output        vga_vs,    
    output        vga_blank,    
    output [ 9:0] pixel_xpos,  
    output [ 9:0] pixel_ypos   
);


parameter  H_SYNC   =  10'd96;    
parameter  H_BACK   =  10'd48;    
parameter  H_DISP   =  10'd640;   
parameter  H_FRONT  =  10'd16;    
parameter  H_TOTAL  =  10'd800;   

parameter  V_SYNC   =  10'd2;     
parameter  V_BACK   =  10'd33;    
parameter  V_DISP   =  10'd480;   
parameter  V_FRONT  =  10'd10;    
parameter  V_TOTAL  =  10'd525;   

localparam START = 4'b0001;
localparam SPEED = 4'b0010;
localparam PLAY  = 4'b0100;
localparam END   = 4'b1000;


reg [ 9:0] H_cnt;   
reg [ 9:0] V_cnt;   
reg [15:0] vga_m;   

wire vga_en;        
wire pixel_req;     




assign vga_hs = (H_cnt >= H_SYNC) ? 1'b1 : 1'b0; 
assign vga_vs = (V_cnt >= V_SYNC) ? 1'b1 : 1'b0; 


assign vga_en = (((H_cnt >= (H_SYNC+H_BACK)) && (H_cnt < (H_TOTAL-H_FRONT)))
                 && ((V_cnt >= (V_SYNC+V_BACK)) && (V_cnt < (V_TOTAL-V_FRONT))))
                 ? 1'b1 : 1'b0;
assign vga_blank = vga_en;  
                    

assign vga_rgb = vga_m;
always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n) 
        vga_m <= 16'd0;
    else if(vga_en) begin
        case(state_m)
            START:   vga_m <= data_start;
            SPEED:   vga_m <= data_speed;
            PLAY :   vga_m <= data_play;  
            END  :   vga_m <= data_end;
            default: vga_m <= data_start;
        endcase
    end
    else
        vga_m <= 16'd0;
end                


assign pixel_req = (((H_cnt >= (H_SYNC+H_BACK-10'd1)) && (H_cnt < (H_TOTAL-H_FRONT-10'd1)))
                 && ((V_cnt >= (V_SYNC+V_BACK)) && (V_cnt < (V_TOTAL-V_FRONT))))
                 ? 1'b1 : 1'b0;
assign pixel_xpos = pixel_req ? (H_cnt - (H_SYNC+H_BACK-10'd1)) : 10'd0;
assign pixel_ypos = pixel_req ? (V_cnt - (V_SYNC+V_BACK-10'd1)) : 10'd0;              


always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n) begin
        H_cnt <= 10'd0;
    end
    else begin
        if(H_cnt == H_TOTAL - 10'd1) 
            H_cnt <= 10'd0;
        else 
            H_cnt <= H_cnt + 10'd1;
    end

end


always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n) begin
        V_cnt <= 10'd0;
    end
    else if(H_cnt == H_TOTAL - 10'd1) begin
        if(V_cnt == V_TOTAL - 10'd1) 
            V_cnt <= 10'd0;
        else 
            V_cnt <= V_cnt + 10'd1;
    end
    else 
        V_cnt <= V_cnt;
end

endmodule 