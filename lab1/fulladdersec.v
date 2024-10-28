module fulladdersec
(
input wire KEY1,
input wire KEY2,
input wire KEY3,
output wire SUM,
output wire C
);

wire notSum;
wire notC;
assign notSum = ~KEY1 ^ ~KEY2 ^ ~KEY3;
assign notC = (~KEY1 &~ KEY2)|(~KEY1 & ~KEY3)| (~KEY2 &~KEY3);
assign SUM = ~notSum;
assign C= ~notC;
endmodule
