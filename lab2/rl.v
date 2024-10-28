module rl (
    input wire clk,
    input wire res,
    output wire [3:0] led
);

reg [24:0] cnt;
reg [3:0] led_state;

always @(posedge clk or negedge res) begin
    if (~res) begin
        led_state <= 4'b0001;
        cnt <= 25'd25000000;
    end
    else if(cnt==25'd25000000 - 1) begin
        if (led_state == 4'b1000) begin
            led_state <= 4'b0001;
        end
        else
        begin
            led_state = led_state << 1;
        end
        cnt <= 25'd0;
    end
    else begin
            cnt <= cnt + 25'd1;
    end
end
    
assign led = ~led_state;

endmodule
