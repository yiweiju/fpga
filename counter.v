module counter (
    input  wire clk,
    input wire res,
    output reg opt
);

reg [24:0] cnt;
initial opt <= 1;

always @(posedge clk or posedge res) begin
    if (res) begin
        opt <= 1'b1;
        cnt <= 25'd25000000;
    end
    else if(cnt==25'd25000000 - 1) begin
        opt <= ~opt;
        cnt <= 25'd0;
    end
    else begin
            cnt <= cnt + 1;
    end
end
    
endmodule