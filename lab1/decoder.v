module decoder (
    input wire [1:0] key,
    input wire En,
    output wire [3:0] opt
);

wire notEn;

assign opt[0] = key[0] & key[1] & En;
assign opt[1] = ~key[0]&key[1]&En;
assign opt[2] = key[0]&~key[1]&En;
assign opt[3] = ~key[0]&~key[1]&En;
    
endmodule
