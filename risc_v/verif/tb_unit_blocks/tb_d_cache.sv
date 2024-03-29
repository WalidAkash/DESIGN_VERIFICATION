module tb_d_cache ();
  import rv32i_pkg::DPW;
  import rv32i_pkg::ADW;
  // Parameters
  localparam int ElemWidth = 8;
  localparam int Depth = 120;

  // Ports
  logic           clk = 0;
  logic [DPW-1:0] addr;
  logic [DPW-1:0] wd;
  logic [DPW-1:0] we;
  logic           data_en;
  logic [DPW-1:0] input_data;
  logic [DPW-1:0] input_addr;
  logic [DPW-1:0] rd;

  d_cache #(
      .ElemWidth(ElemWidth),
      .Depth    (Depth)
  ) d_cache_dut (
      .clk       (clk),
      .addr      (addr),
      .wd        (wd),
      .we        (we),
      .data_en   (data_en),
      .input_data(input_data),
      .input_addr(input_addr),
      .rd        (rd)
  );


  always #5 clk = !clk;

  task static data_in;
    input logic [DPW-1:0] x;
    input logic [DPW-1:0] y;

    begin
      @(posedge clk) data_en <= 1;
      input_addr <= x;
      input_data <= y;
      @(posedge clk);
      data_en <= 0;
      @(posedge clk);
    end
  endtask

  initial begin
    $display("\033[7;38m####################### TEST STARTED #######################\033[0m");
    $dumpfile("raw.vcd");
    $dumpvars;
  end

  final begin
    $display("\033[7;38m######################## TEST ENDED ########################\033[0m");
  end

  initial begin
    data_in(32'h0, 32'h4);
    data_in(32'h4, 32'h5);
    data_in(32'h8, 32'h6);
    data_in(32'hC, 32'h7);
    repeat (2) @(posedge clk);

    data_en <= 0;
    we <= 0;

    addr <= 32'h0;
    repeat (2) @(posedge clk);

    $display("rd1 = %h", rd);
    repeat (2) @(posedge clk);

    addr <= 32'h4;
    repeat (2) @(posedge clk);

    $display("rd2 = %h", rd);
    repeat (2) @(posedge clk);

    we   <= 1;
    addr <= 32'h7;
    wd   <= 32'hA;
    repeat (2) @(posedge clk);

    we   <= 0;
    addr <= 32'h7;
    repeat (2) @(posedge clk);

    $display("rd3 = %h", rd);
    repeat (2) @(posedge clk);
    repeat (2) @(posedge clk);


    $finish;
  end

endmodule
