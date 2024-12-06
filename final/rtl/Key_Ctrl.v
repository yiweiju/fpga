module Key_Ctrl(   
    input        clk,         
    input        rst_n,         
    input  [3:0] key,           
    input        game_over,     

    output [3:0] state_m,       
    output [3:0] move_d,        
    output  reg  speed_m        
);



localparam START = 4'b0001;
localparam SPEED = 4'b0010;
localparam PLAY  = 4'b0100;
localparam END   = 4'b1000;

localparam RIGHT = 4'b0001;  
localparam LEFT  = 4'b0010;  
localparam DOWN  = 4'b0100;  
localparam UP    = 4'b1000;  


reg [ 3:0] state_c;     
reg [ 3:0] state_n;      
reg [ 1:0] change_cond;  
reg [ 3:0] move_dirt;    

reg [31:0] play_cnt; 
reg        play_key;    


reg [31:0] delay_cnt;
reg [ 3:0] key_delay;



assign state_m = state_c; 
assign move_d  = move_dirt; 


always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        state_c <= START;
    else 
        state_c <= state_n;
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n)begin
		key_delay <= 4'b1111;
		delay_cnt <= 32'd0;
		end
	else if(delay_cnt == 32'd100_0000)begin
		key_delay <= key;
		delay_cnt <= delay_cnt;
		end
	else begin 
		key_delay <= 4'b1111;
		delay_cnt <= delay_cnt + 32'd1;
		end
end

always @(*) begin
    case(state_c)
        START:  begin                 
            if(change_cond == 2'b01)   
                state_n = SPEED;
            else 
                state_n = START;
        end 
        
        SPEED:  begin                 
            if(change_cond == 2'b10)   
                state_n = PLAY;       
            else 
                state_n = SPEED;
        end
        
        PLAY:  begin                  
           if(game_over)
                state_n = END;
            else 
                state_n = PLAY;
        end
        
        END:    begin                 
            if(change_cond == 2'd0)   
                state_n =  START;  
            else
                state_n =  END;
        end
        
        default: 
                state_n = START; 
    endcase
end

 

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        speed_m <= 1'b1;   
    else begin
        if(state_c == SPEED) 
            if(!key_delay[0]) 
                speed_m <= 1'b0;    
            else if(!key_delay[1])
                speed_m <= 1'b1;    
            else    
                speed_m <= 1'b1;    
    end   
end


always @(posedge clk or negedge rst_n)
begin
    if(!rst_n) begin
        play_cnt <= 32'd0;
        play_key <= 1'b0;
    end
    else if(state_c == START) begin     
        play_cnt <= 32'd0; 
        play_key <= 1'b0;
    end
    else if(state_c == PLAY) begin
        if(play_cnt == 32'd12_500_000) begin
            play_key <= 1'b1;
            play_cnt <= 32'd0;
        end
        else
            play_cnt <= play_cnt + 1'b1;
    end
end


always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        move_dirt <= RIGHT;         
    else if(state_c == START)
        move_dirt <= RIGHT;         
    else if(play_key == 1'b1) begin
        case(key_delay)
            4'b1110: begin          
                if(move_dirt == LEFT || move_dirt == RIGHT)
                    move_dirt <= UP;         
                else
                    move_dirt <= move_dirt;
            end
            4'b1101: begin          
                if(move_dirt == LEFT || move_dirt == RIGHT)
                    move_dirt <= DOWN;         
                else
                    move_dirt <= move_dirt;       
            end
            4'b1011: begin          
                if(move_dirt == UP || move_dirt == DOWN)
                    move_dirt <= LEFT;         
                else
                    move_dirt <= move_dirt;             
            end
            4'b0111: begin          
                if(move_dirt == UP || move_dirt == DOWN)
                    move_dirt <= RIGHT;         
                else
                    move_dirt <= move_dirt;       
            end
            default: move_dirt <= move_dirt;  
        endcase
    end   
    else move_dirt <= move_dirt;  
end



always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)  begin
        change_cond <= 2'b0;
 
    end   
    else begin
   
        if(key_delay != 4'b1111)  begin    
            if(state_c == START && (key_delay == 4'b0111))                               
                change_cond <= 2'b01;     
            else if(state_c == SPEED )  
                case(key_delay) 	
					4'b1110:change_cond <= 2'b10;
					4'b1101:change_cond <= 2'b10;
					default:change_cond <= change_cond;
				endcase
            else if(state_c == END && key_delay[0])                 
                change_cond <= 2'b0;
            else    
                change_cond <= change_cond;
        end
        else
            change_cond <= change_cond; 
    end   
end

endmodule 