module Game_Play(
    input            vga_clk_25,     
    input            rst_n,            
    input     [ 9:0] pixel_xpos,      
    input     [ 9:0] pixel_ypos,       
    input     [ 3:0] state_m,          
    input            speed_m,          
    input     [ 3:0] move_dirt,        
    
    output           game_over,        
    output    [ 5:0] game_score,       
    output reg[15:0] pixel_data        
);


parameter   H_DISP = 10'd640;          
parameter   V_DISP = 10'd480;          

localparam  Border = 10'd16;           
localparam  BODY   = 10'd16;           
localparam  FAST   = 24'd3750_000;     
localparam  SLOW   = 24'd6250_000;     

localparam  WHITE  = 16'hFFFF;  
localparam  BLANK  = 16'h0000;  
localparam  RED    = 16'hF100;  
localparam  GREEN  = 16'h0400;  
localparam  BLUE   = 16'h001F;  
localparam  YELLOW = 16'hFFE0;  
localparam  PURPLE = 16'h8010;  
localparam  BROWN  = 16'hE618;  

localparam START = 4'b0001;
localparam SPEED = 4'b0010;
localparam PLAY  = 4'b0100;
localparam END   = 4'b1000;

localparam RIGHT = 4'b0001;  
localparam LEFT  = 4'b0010;  
localparam DOWN  = 4'b0100;
localparam UP    = 4'b1000;  


reg [23:0] speed_cnt;     
reg        move_en;       
reg [ 9:0] head_x;        
reg [ 9:0] head_y;        
reg [ 9:0] body_x [26:0]; 
reg [ 9:0] body_y [26:0]; 
reg        meet_wall;     
reg        meet_body;     
reg [ 9:0] apple_x;       
reg [ 9:0] apple_y;       
reg [ 9:0] aple_x_cnt;    
reg [ 9:0] aple_y_cnt;    
reg        apple_eat;     
reg [ 5:0] apple_cnt;     




assign game_over  = meet_wall || meet_body;

assign game_score = apple_cnt;


 

always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n) begin
        speed_cnt  <= 24'd0;
        move_en    <= 1'b0; 
    end
    else begin
        case(speed_m)
            1'b0:  begin
                if(speed_cnt == FAST - 1'b1) begin
                    speed_cnt <= 24'd0;
                    move_en   <= 1'b1;
                end
                else begin    
                    speed_cnt <= speed_cnt + 1'b1;
                    move_en   <= 1'b0;
                end
            end

            1'b1:  begin
                if(speed_cnt == SLOW - 1'b1) begin
                    speed_cnt <= 24'd0;
                    move_en   <= 1'b1;
                end
                else begin    
                    speed_cnt <= speed_cnt + 1'b1;
                    move_en   <= 1'b0;
                end
            end
            
            default: begin
                speed_cnt <= 24'd0;
                move_en   <= 1'b0; 
            end
        endcase
    end
end





always @(posedge move_en or negedge rst_n)
begin
    if(!rst_n) begin
        head_x    <= 10'd96;         
        head_y    <= 10'd48;         
        body_x[0] <= 10'd96 - BODY;  
        body_y[0] <= 10'd48;         
		body_x[1] <= 10'd80 - BODY; 
        body_y[1] <= 10'd48; 
		body_x[2] <= 10'd64 - BODY; 
        body_y[2] <= 10'd48; 
		body_x[3] <= 10'd48 - BODY; 
        body_y[3] <= 10'd48; 
    end
    else if(state_m == START) begin  
        head_x    <= 10'd96;        
        head_y    <= 10'd48;        
        body_x[0] <= 10'd96 - BODY; 
        body_y[0] <= 10'd48; 
		body_x[1] <= 10'd80 - BODY; 
        body_y[1] <= 10'd48; 
		body_x[2] <= 10'd64 - BODY; 
        body_y[2] <= 10'd48; 
		body_x[3] <= 10'd48 - BODY; 
        body_y[3] <= 10'd48; 
    end
    else if(state_m == PLAY) begin 
        case(move_dirt) 
            RIGHT:   begin
                head_x    <= head_x + 10'd16;
                head_y    <= head_y;
                body_x[0] <= head_x;
                body_y[0] <= head_y;
			 	body_x[1] <= body_x[0];
				body_y[1] <= body_y[0];
			 	body_x[2] <= body_x[1];
				body_y[2] <= body_y[1];
			 	body_x[3] <= body_x[2];
				body_y[3] <= body_y[2];
            end
            
            LEFT:    begin
                head_x    <= head_x - 10'd16;
                head_y    <= head_y;
                body_x[0] <= head_x; 
                body_y[0] <= head_y;
			 	body_x[1] <= body_x[0];
				body_y[1] <= body_y[0];
			 	body_x[2] <= body_x[1];
				body_y[2] <= body_y[1];
			 	body_x[3] <= body_x[2];
				body_y[3] <= body_y[2];
            end
            
            DOWN:    begin
                head_y    <= head_y + 10'd16;
                head_x    <= head_x;
                body_y[0] <= head_y;  
                body_x[0] <= head_x;
			 	body_x[1] <= body_x[0];
				body_y[1] <= body_y[0];
			 	body_x[2] <= body_x[1];
				body_y[2] <= body_y[1];
			 	body_x[3] <= body_x[2];
				body_y[3] <= body_y[2];
            end
            
            UP:      begin
                head_y    <= head_y - 10'd16;
                head_x    <= head_x;
                body_y[0] <= head_y;
                body_x[0] <= head_x;
			 	body_x[1] <= body_x[0];
				body_y[1] <= body_y[0];
			 	body_x[2] <= body_x[1];
				body_y[2] <= body_y[1];
			 	body_x[3] <= body_x[2];
				body_y[3] <= body_y[2];
            end
        
            default: begin
                head_x    <= 10'd0;
                head_y    <= 10'd0;
                body_x[0] <= 10'd0;
                body_y[0] <= 10'd0;
				body_x[1] <= 10'd0;
                body_y[1] <= 10'd0;
				body_x[2] <= 10'd0;
                body_y[2] <= 10'd0;
				body_x[3] <= 10'd0;
                body_y[3] <= 10'd0;
				
            end
        endcase 
    end   
end


always @(posedge move_en or negedge rst_n)
begin
    if(!rst_n) begin
        body_x[ 24] <= 10'd0;   body_y[ 24] <= 10'd0;  
        body_x[ 25] <= 10'd0;   body_y[ 25] <= 10'd0;
        body_x[ 26] <= 10'd0;   body_y[ 26] <= 10'd0;



        body_x[ 4] <= 10'd0;   body_y[ 4] <= 10'd0;
        body_x[ 5] <= 10'd0;   body_y[ 5] <= 10'd0;
        body_x[ 6] <= 10'd0;   body_y[ 6] <= 10'd0;
        body_x[ 7] <= 10'd0;   body_y[ 7] <= 10'd0;
        body_x[ 8] <= 10'd0;   body_y[ 8] <= 10'd0;
        body_x[ 9] <= 10'd0;   body_y[ 9] <= 10'd0;  
        body_x[10] <= 10'd0;   body_y[10] <= 10'd0;
        body_x[11] <= 10'd0;   body_y[11] <= 10'd0;
        body_x[12] <= 10'd0;   body_y[12] <= 10'd0;
        body_x[13] <= 10'd0;   body_y[13] <= 10'd0;
        body_x[14] <= 10'd0;   body_y[14] <= 10'd0;
        body_x[15] <= 10'd0;   body_y[15] <= 10'd0;
        body_x[16] <= 10'd0;   body_y[16] <= 10'd0;
        body_x[17] <= 10'd0;   body_y[17] <= 10'd0;
        body_x[18] <= 10'd0;   body_y[18] <= 10'd0;
        body_x[19] <= 10'd0;   body_y[19] <= 10'd0;
        body_x[20] <= 10'd0;   body_y[20] <= 10'd0;
        body_x[21] <= 10'd0;   body_y[21] <= 10'd0;
        body_x[22] <= 10'd0;   body_y[22] <= 10'd0;
        body_x[23] <= 10'd0;   body_y[23] <= 10'd0;
    end
    else if(state_m == START) begin                  
        body_x[ 24] <= 10'd0;   body_y[ 24] <= 10'd0;  
        body_x[ 25] <= 10'd0;   body_y[ 25] <= 10'd0;
        body_x[ 26] <= 10'd0;   body_y[ 26] <= 10'd0;
        body_x[ 4] <= 10'd0;   body_y[ 4] <= 10'd0;
        body_x[ 5] <= 10'd0;   body_y[ 5] <= 10'd0;
        body_x[ 6] <= 10'd0;   body_y[ 6] <= 10'd0;
        body_x[ 7] <= 10'd0;   body_y[ 7] <= 10'd0;
        body_x[ 8] <= 10'd0;   body_y[ 8] <= 10'd0;
        body_x[ 9] <= 10'd0;   body_y[ 9] <= 10'd0;  
        body_x[10] <= 10'd0;   body_y[10] <= 10'd0;
        body_x[11] <= 10'd0;   body_y[11] <= 10'd0;
        body_x[12] <= 10'd0;   body_y[12] <= 10'd0;
        body_x[13] <= 10'd0;   body_y[13] <= 10'd0;
        body_x[14] <= 10'd0;   body_y[14] <= 10'd0;
        body_x[15] <= 10'd0;   body_y[15] <= 10'd0;
        body_x[16] <= 10'd0;   body_y[16] <= 10'd0;
        body_x[17] <= 10'd0;   body_y[17] <= 10'd0;
        body_x[18] <= 10'd0;   body_y[18] <= 10'd0;
        body_x[19] <= 10'd0;   body_y[19] <= 10'd0;
        body_x[20] <= 10'd0;   body_y[20] <= 10'd0;
        body_x[21] <= 10'd0;   body_y[21] <= 10'd0;
        body_x[22] <= 10'd0;   body_y[22] <= 10'd0;
        body_x[23] <= 10'd0;   body_y[23] <= 10'd0;
    end
    else if(state_m == PLAY) begin                     
        case(move_dirt)                              
            RIGHT,LEFT,DOWN,UP:   begin              
                if(apple_cnt >= 6'd1)  begin body_x[ 4] <= body_x[ 3];  body_y[ 4] <= body_y[ 3];  
                if(apple_cnt >= 6'd2)  begin body_x[ 5] <= body_x[ 4];  body_y[ 5] <= body_y[ 4];
                if(apple_cnt >= 6'd3)  begin body_x[ 6] <= body_x[ 5];  body_y[ 6] <= body_y[ 5];
                if(apple_cnt >= 6'd4)  begin body_x[ 7] <= body_x[ 6];  body_y[ 7] <= body_y[ 6];
                if(apple_cnt >= 6'd5)  begin body_x[ 8] <= body_x[ 7];  body_y[ 8] <= body_y[ 7];
                if(apple_cnt >= 6'd6)  begin body_x[ 9] <= body_x[ 8];  body_y[ 9] <= body_y[ 8];
                if(apple_cnt >= 6'd7)  begin body_x[10] <= body_x[ 9];  body_y[10] <= body_y[ 9];
                if(apple_cnt >= 6'd8)  begin body_x[11] <= body_x[10];  body_y[11] <= body_y[10];
                if(apple_cnt >= 6'd9)  begin body_x[12] <= body_x[11];  body_y[12] <= body_y[11];
                if(apple_cnt >= 6'd10) begin body_x[13] <= body_x[12];  body_y[13] <= body_y[12];
                if(apple_cnt >= 6'd11) begin body_x[14] <= body_x[13];  body_y[14] <= body_y[13];
                if(apple_cnt >= 6'd12) begin body_x[15] <= body_x[14];  body_y[15] <= body_y[14];
                if(apple_cnt >= 6'd13) begin body_x[16] <= body_x[15];  body_y[16] <= body_y[15];
                if(apple_cnt >= 6'd14) begin body_x[17] <= body_x[16];  body_y[17] <= body_y[16];
                if(apple_cnt >= 6'd15) begin body_x[18] <= body_x[17];  body_y[18] <= body_y[17];
                if(apple_cnt >= 6'd16) begin body_x[19] <= body_x[18];  body_y[19] <= body_y[18];
                if(apple_cnt >= 6'd17) begin body_x[20] <= body_x[19];  body_y[20] <= body_y[19];
                if(apple_cnt >= 6'd18) begin body_x[21] <= body_x[20];  body_y[21] <= body_y[20];
                if(apple_cnt >= 6'd19) begin body_x[22] <= body_x[21];  body_y[22] <= body_y[21];
                if(apple_cnt >= 6'd20) begin body_x[23] <= body_x[22];  body_y[23] <= body_y[22];
                if(apple_cnt >= 6'd21) begin body_x[24] <= body_x[23];  body_y[24] <= body_y[23];
                if(apple_cnt >= 6'd22) begin body_x[25] <= body_x[24];  body_y[25] <= body_y[24];
                if(apple_cnt >= 6'd23) begin body_x[26] <= body_x[25];  body_y[26] <= body_y[25];

                end end end end end end end end end end
                end end end end end end end end end end
                end end end      
            end 
            default: ;
        endcase 
    end
end


always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n) begin
        apple_eat <= 1'b0;
        apple_cnt <= 6'd0;
    end
    else if(state_m == START)              
        apple_cnt <= 6'd0;
    else if(state_m == PLAY) begin
        if( (((head_x >= apple_x) && (head_x < apple_x+BODY)) && ((head_y >= apple_y) && (head_y < apple_y+BODY))) ) begin
            apple_eat <= 1'b1;             
            if(apple_eat == 1'b0)
                apple_cnt <= apple_cnt + 1'b1;
            else
                apple_cnt <= apple_cnt;
        end
        else 
            apple_eat <= 1'b0;
    end
end





always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n) begin
        apple_x    <= 10'd352;        
        apple_y    <= 10'd256;
        aple_x_cnt <= 10'd16;         
        aple_y_cnt <= 10'd16;
    end
    else if(state_m == START) begin   
        apple_x    <= 10'd352;        
        apple_y    <= 10'd256;
    end  
    else if(state_m == PLAY) begin    
        if(apple_eat == 1'b1) begin  
            apple_x <= aple_x_cnt;
            apple_y <= aple_y_cnt;
        end  
        else if(aple_x_cnt > H_DISP-Border-BODY-10'd16)
            aple_x_cnt <= 10'd32;
        else if(aple_y_cnt > V_DISP-Border-BODY-10'd16)
            aple_y_cnt <= 10'd32;
        else begin
            aple_x_cnt <= aple_x_cnt + 10'd16;
            aple_y_cnt <= aple_y_cnt + 10'd16;
        end
    end
end




always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n)
        meet_wall <= 1'b0;  
    else if(state_m == START) 
        meet_wall <= 1'b0;
    else if(state_m == PLAY) begin
        if( ((head_x < Border) || (head_x > H_DISP-Border-BODY))
          || ((head_y < Border) || (head_y > V_DISP-Border-BODY)) )
            meet_wall <= 1'b1; 
        else
            meet_wall <= 1'b0;
    end
end


always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n)
        meet_body <= 1'b0;  
    else if(state_m == START) 
        meet_body <= 1'b0;
    else if(state_m == PLAY) begin
        if( (((head_x >= body_x[0]) && (head_x < body_x[0]+BODY)) && ((head_y >= body_y[0]) && (head_y < body_y[0]+BODY)))
          || (((head_x >= body_x[1]) && (head_x < body_x[1]+BODY)) && ((head_y >= body_y[1]) && (head_y < body_y[1]+BODY)))
          || (((head_x >= body_x[2]) && (head_x < body_x[2]+BODY)) && ((head_y >= body_y[2]) && (head_y < body_y[2]+BODY)))
          || (((head_x >= body_x[3]) && (head_x < body_x[3]+BODY)) && ((head_y >= body_y[3]) && (head_y < body_y[3]+BODY)))
          || (((head_x >= body_x[4]) && (head_x < body_x[4]+BODY)) && ((head_y >= body_y[4]) && (head_y < body_y[4]+BODY)))
          || (((head_x >= body_x[5]) && (head_x < body_x[5]+BODY)) && ((head_y >= body_y[5]) && (head_y < body_y[5]+BODY)))
          || (((head_x >= body_x[6]) && (head_x < body_x[6]+BODY)) && ((head_y >= body_y[6]) && (head_y < body_y[6]+BODY)))
          || (((head_x >= body_x[7]) && (head_x < body_x[7]+BODY)) && ((head_y >= body_y[7]) && (head_y < body_y[7]+BODY)))
          || (((head_x >= body_x[8]) && (head_x < body_x[8]+BODY)) && ((head_y >= body_y[8]) && (head_y < body_y[8]+BODY)))
          || (((head_x >= body_x[9]) && (head_x < body_x[9]+BODY)) && ((head_y >= body_y[9]) && (head_y < body_y[9]+BODY)))
          || (((head_x >= body_x[10]) && (head_x < body_x[10]+BODY)) && ((head_y >= body_y[10]) && (head_y < body_y[10]+BODY)))
          || (((head_x >= body_x[11]) && (head_x < body_x[11]+BODY)) && ((head_y >= body_y[11]) && (head_y < body_y[11]+BODY)))
          || (((head_x >= body_x[12]) && (head_x < body_x[12]+BODY)) && ((head_y >= body_y[12]) && (head_y < body_y[12]+BODY)))
          || (((head_x >= body_x[13]) && (head_x < body_x[13]+BODY)) && ((head_y >= body_y[13]) && (head_y < body_y[13]+BODY)))
          || (((head_x >= body_x[14]) && (head_x < body_x[14]+BODY)) && ((head_y >= body_y[14]) && (head_y < body_y[14]+BODY)))
          || (((head_x >= body_x[15]) && (head_x < body_x[15]+BODY)) && ((head_y >= body_y[15]) && (head_y < body_y[15]+BODY)))
          || (((head_x >= body_x[16]) && (head_x < body_x[16]+BODY)) && ((head_y >= body_y[16]) && (head_y < body_y[16]+BODY)))
          || (((head_x >= body_x[17]) && (head_x < body_x[17]+BODY)) && ((head_y >= body_y[17]) && (head_y < body_y[17]+BODY)))
          || (((head_x >= body_x[18]) && (head_x < body_x[18]+BODY)) && ((head_y >= body_y[18]) && (head_y < body_y[18]+BODY)))
          || (((head_x >= body_x[19]) && (head_x < body_x[19]+BODY)) && ((head_y >= body_y[19]) && (head_y < body_y[19]+BODY)))
          || (((head_x >= body_x[20]) && (head_x < body_x[20]+BODY)) && ((head_y >= body_y[20]) && (head_y < body_y[20]+BODY)))
          || (((head_x >= body_x[21]) && (head_x < body_x[21]+BODY)) && ((head_y >= body_y[21]) && (head_y < body_y[21]+BODY)))
          || (((head_x >= body_x[22]) && (head_x < body_x[22]+BODY)) && ((head_y >= body_y[22]) && (head_y < body_y[22]+BODY)))
          || (((head_x >= body_x[23]) && (head_x < body_x[23]+BODY)) && ((head_y >= body_y[23]) && (head_y < body_y[23]+BODY)))
		  || (((head_x >= body_x[24]) && (head_x < body_x[24]+BODY)) && ((head_y >= body_y[24]) && (head_y < body_y[24]+BODY)))
		  || (((head_x >= body_x[25]) && (head_x < body_x[25]+BODY)) && ((head_y >= body_y[25]) && (head_y < body_y[25]+BODY)))
		  || (((head_x >= body_x[26]) && (head_x < body_x[26]+BODY)) && ((head_y >= body_y[26]) && (head_y < body_y[26]+BODY)))
          )
            meet_body <= 1'b1; 
        else
            meet_body <= 1'b0;
    end
end





always @(posedge vga_clk_25 or negedge rst_n)
begin
    if(!rst_n)
        pixel_data <= 16'd0; 
    else begin
        
        if( ((pixel_xpos < Border) || (pixel_xpos >= H_DISP-Border)) || ((pixel_ypos < Border) || (pixel_ypos >= V_DISP-Border)) )
            pixel_data <= RED;
        
        else if( ((pixel_xpos >= apple_x) && (pixel_xpos < apple_x+BODY)) && ((pixel_ypos >= apple_y) && (pixel_ypos < apple_y+BODY)) )
            pixel_data <= YELLOW;
        
        else if( ((pixel_xpos >= head_x) && (pixel_xpos < head_x+BODY)) && ((pixel_ypos >= head_y) && (pixel_ypos < head_y+BODY)) ) 
            pixel_data <= GREEN;
        
        else if(  (((pixel_xpos >= body_x[0]) && (pixel_xpos < body_x[0]+BODY)) && ((pixel_ypos >= body_y[0]) && (pixel_ypos < body_y[0]+BODY)))
               || (((pixel_xpos >= body_x[1]) && (pixel_xpos < body_x[1]+BODY)) && ((pixel_ypos >= body_y[1]) && (pixel_ypos < body_y[1]+BODY)))
               || (((pixel_xpos >= body_x[2]) && (pixel_xpos < body_x[2]+BODY)) && ((pixel_ypos >= body_y[2]) && (pixel_ypos < body_y[2]+BODY)))
               || (((pixel_xpos >= body_x[3]) && (pixel_xpos < body_x[3]+BODY)) && ((pixel_ypos >= body_y[3]) && (pixel_ypos < body_y[3]+BODY)))
               || (((pixel_xpos >= body_x[4]) && (pixel_xpos < body_x[4]+BODY)) && ((pixel_ypos >= body_y[4]) && (pixel_ypos < body_y[4]+BODY)))
               || (((pixel_xpos >= body_x[5]) && (pixel_xpos < body_x[5]+BODY)) && ((pixel_ypos >= body_y[5]) && (pixel_ypos < body_y[5]+BODY)))
               || (((pixel_xpos >= body_x[6]) && (pixel_xpos < body_x[6]+BODY)) && ((pixel_ypos >= body_y[6]) && (pixel_ypos < body_y[6]+BODY)))
               || (((pixel_xpos >= body_x[7]) && (pixel_xpos < body_x[7]+BODY)) && ((pixel_ypos >= body_y[7]) && (pixel_ypos < body_y[7]+BODY)))
               || (((pixel_xpos >= body_x[8]) && (pixel_xpos < body_x[8]+BODY)) && ((pixel_ypos >= body_y[8]) && (pixel_ypos < body_y[8]+BODY)))
               || (((pixel_xpos >= body_x[9]) && (pixel_xpos < body_x[9]+BODY)) && ((pixel_ypos >= body_y[9]) && (pixel_ypos < body_y[9]+BODY)))
               || (((pixel_xpos >= body_x[10]) && (pixel_xpos < body_x[10]+BODY)) && ((pixel_ypos >= body_y[10]) && (pixel_ypos < body_y[10]+BODY)))
               || (((pixel_xpos >= body_x[11]) && (pixel_xpos < body_x[11]+BODY)) && ((pixel_ypos >= body_y[11]) && (pixel_ypos < body_y[11]+BODY)))
               || (((pixel_xpos >= body_x[12]) && (pixel_xpos < body_x[12]+BODY)) && ((pixel_ypos >= body_y[12]) && (pixel_ypos < body_y[12]+BODY)))
               || (((pixel_xpos >= body_x[13]) && (pixel_xpos < body_x[13]+BODY)) && ((pixel_ypos >= body_y[13]) && (pixel_ypos < body_y[13]+BODY)))
               || (((pixel_xpos >= body_x[14]) && (pixel_xpos < body_x[14]+BODY)) && ((pixel_ypos >= body_y[14]) && (pixel_ypos < body_y[14]+BODY)))
               || (((pixel_xpos >= body_x[15]) && (pixel_xpos < body_x[15]+BODY)) && ((pixel_ypos >= body_y[15]) && (pixel_ypos < body_y[15]+BODY)))
               || (((pixel_xpos >= body_x[16]) && (pixel_xpos < body_x[16]+BODY)) && ((pixel_ypos >= body_y[16]) && (pixel_ypos < body_y[16]+BODY)))
               || (((pixel_xpos >= body_x[17]) && (pixel_xpos < body_x[17]+BODY)) && ((pixel_ypos >= body_y[17]) && (pixel_ypos < body_y[17]+BODY)))
               || (((pixel_xpos >= body_x[18]) && (pixel_xpos < body_x[18]+BODY)) && ((pixel_ypos >= body_y[18]) && (pixel_ypos < body_y[18]+BODY)))
               || (((pixel_xpos >= body_x[19]) && (pixel_xpos < body_x[19]+BODY)) && ((pixel_ypos >= body_y[19]) && (pixel_ypos < body_y[19]+BODY)))
               || (((pixel_xpos >= body_x[20]) && (pixel_xpos < body_x[20]+BODY)) && ((pixel_ypos >= body_y[20]) && (pixel_ypos < body_y[20]+BODY)))
               || (((pixel_xpos >= body_x[21]) && (pixel_xpos < body_x[21]+BODY)) && ((pixel_ypos >= body_y[21]) && (pixel_ypos < body_y[21]+BODY)))
               || (((pixel_xpos >= body_x[22]) && (pixel_xpos < body_x[22]+BODY)) && ((pixel_ypos >= body_y[22]) && (pixel_ypos < body_y[22]+BODY)))
               || (((pixel_xpos >= body_x[23]) && (pixel_xpos < body_x[23]+BODY)) && ((pixel_ypos >= body_y[23]) && (pixel_ypos < body_y[23]+BODY)))
               )
            pixel_data <= BLUE; 
        
        else    
            pixel_data <= BLANK;  
    end         
end

endmodule 