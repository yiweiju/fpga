module comparator 
(
    input  wire [1:0] key,
    output wire [2:0] opt
);

assign opt[0] = key[0]&~key[1];
assign opt[1] = key[0]&key[1] | ~key[0]&~key[1];
assign opt[2] = ~key[0]&key[1];
    
endmodule