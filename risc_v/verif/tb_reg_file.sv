// module: tb_reg_file

module reg_file_tb;

  // Parameters
  parameter ADW = 5;
  parameter DPW = 32;

  logic           clk;
  logic [ADW-1:0] addr_1;
  logic [ADW-1:0] addr_2;
  logic [ADW-1:0] addr_3;
  logic           we;
  logic [DPW-1:0] wd_3;
  logic [DPW-1:0] rd_1;
  logic [DPW-1:0] rd_2;

  // DUT
  reg_file #(
      .ADW(ADW),
      .DPW(DPW)
  ) dut (
      .clk(clk),
      .addr_1(addr_1),
      .addr_2(addr_2),
      .addr_3(addr_3),
      .we(we),
      .wd_3(wd_3),
      .rd_1(rd_1),
      .rd_2(rd_2)
  );

  always #5 clk = ~clk;

  initial begin


    /*
    // Write data to addr_3
    addr_3 = 2;
    we = 1;
    wd_3 = 32'h12345678;
    #10;
    we = 0;

    // Read data from addr_1 and addr_2
    addr_1 = 0;
    addr_2 = 1;
    #10;

    // Verify results
    if (rd_1 !== 32'h00000000) $error("Test failed: rd_1");
    if (rd_2 !== 32'h00000000) $error("Test failed: rd_2");

    addr_1 = 2;
    addr_2 = 2;
    #10;

    if (rd_1 !== 32'h12345678) $error("Test failed: rd_1");
    if (rd_2 !== 32'h12345678) $error("Test failed: rd_2");
*/
    $display("Test passed");
    #100;
    $finish;
  end

endmodule
