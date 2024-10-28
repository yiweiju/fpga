module tb_fulladdersec;

  reg  KEY1;
  reg  KEY2;
  reg  KEY3;
  wire  SUM;
  wire  C;

 fulladdersec  fulladder_inst (
    .KEY1(KEY1),
    .KEY2(KEY2),
    .KEY3(KEY3),
    .SUM(SUM),
    .C(C)
  );

  initial begin
    $monitor("Time: %0t | k1 = %b  k2 = %b  k3 = %b | sum = %b  c = %b", $time, KEY1,KEY2,KEY3, SUM, C)

    KEY1 = 0;
    KEY2 = 0;
    KEY3 = 0;
    #10;

    KEY1 = 0;
    KEY2 = 0;
    KEY3 = 1;
    #10;

    KEY1 = 0;
    KEY2 = 1;
    KEY3 = 0;
    #10;

    KEY1 = 0;
    KEY2 = 1;
    KEY3 = 1;
    #10;

    KEY1 = 1;
    KEY2 = 0;
    KEY3 = 0;
    #10;

    KEY1 = 1;
    KEY2 = 0;
    KEY3 = 1;
    #10;

    KEY1 = 1;
    KEY2 = 1;
    KEY3 = 0;
    #10;

    KEY1 = 1;
    KEY2 = 1;
    KEY3 = 1;
    #10;

    $stop;

  end
endmodule
