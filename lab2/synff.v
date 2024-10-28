module synff (
    input wire inp,
    input  wire res,
    output reg opt
);

always @(negedge res) begin
    opt <= inp;
end

endmodule