module tb_comparator;
  reg [1:0] key;
  wire [2:0] opt;
  comparator  comparator_inst (
    .key(key),
    .opt(opt)
  );

  initial begin
    $monitor("Time: %0t | key: %b | opt: %b", $time, key, opt);
 
    key = 2'b00;
    #10;

    key = 2'b01;
    #10;

    key = 2'b10;
    #10;

    key = 2'b11;
    #10;
  end


endmodule