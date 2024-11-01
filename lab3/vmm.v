module vmm
 (
    input wire sys_clk,    
    input wire sys_rst_n,  
    input wire coin1,      
    input wire coin05,      
    input wire refun,      
    output wire ref05,
    output wire doref,
    output wire cola  
);

parameter IDLE = 4'b0001;
parameter ONE  = 4'b0010;
parameter TWO  = 4'b0100;
parameter THR  = 4'b1000;

reg [3:0] st_next;
reg [3:0] st_cur;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        st_cur <= IDLE;
	else if (!refun)
	st_cur <= IDLE;
    else
        st_cur <= st_next;
end

always @(*) begin
    if (!refun) begin
        st_next = IDLE;
    end
    case (st_cur)
        IDLE: begin
            if (coin1 == 1'b0) 
            begin
                st_next = TWO;
            end

            else if(coin05 == 1'b0) 
            begin
                st_next = ONE;
            end

            else
            begin
                st_next = IDLE;
            end
        end
        ONE: begin
            if (coin1 == 1'b0) 
            begin
                st_next = THR;
            end

            else if(coin05 == 1'b0) 
            begin
                st_next = TWO;
            end

            else
            begin
                st_next = ONE;
            end
        end
        TWO: begin
            if (coin1 == 1'b0) 
            begin
                st_next = IDLE;
            end

            else if(coin05 == 1'b0) 
            begin
                st_next = THR;
            end

            else
            begin
                st_next = TWO;
            end
        end
        THR: begin
            if (coin1 == 1'b0) 
            begin
                st_next = IDLE;
            end

            else if(coin05 == 1'b0) 
            begin
                st_next = IDLE;
            end

            else
            begin
                st_next = THR;
            end
        end
        default: st_next = IDLE;
    endcase
end


reg cola_r;
reg ref05_r;
reg doref_r;
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        cola_r <= 1'b0;
        ref05_r <= 1'b0;
        doref_r <= 1'b0;
		  end
    else if(refun == 1'b0) begin
        doref_r <= 1'b1;
    end
    else if ((st_cur == TWO) && (coin1 == 1'b0)) begin
        cola_r <= 1'b1;
		  end
    else if ((st_cur == THR) && (coin05 == 1'b0)) begin
        cola_r <= 1'b1;
		  end
    else if ((st_cur == THR) && (coin1 == 1'b0)) begin
        cola_r <= 1'b1;
        ref05_r <= 1'b1;
		  end
    else begin
        cola_r <= 1'b0;
        ref05_r <= 1'b0;
        doref_r <= 1'b0;
		  end
end


assign cola = ~cola_r;
assign ref05 = ~ref05_r;
assign doref = ~doref_r;
    
endmodule