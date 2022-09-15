module vsdbabysoc_1 ( OUT, reset, clk );
  input reset, clk;
  output  [9:0] OUT;
  rvmyth core ( .OUT(OUT), .CLK(clk), .reset(reset) );
endmodule
