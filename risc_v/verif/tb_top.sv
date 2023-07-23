// ### Author : Razu Ahamed(en.razu.ahamed@gmail.com)
// ### Company: DSi
// Description : Testbench for top.sv module

module tb_top ();

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-IMPORTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  import rv32i_pkg::DPW;
  import rv32i_pkg::ADW;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic           clk;
  logic           arst_n;

  logic [DPW-1:0] PCF;
  logic [DPW-1:0] instrD;

  logic [DPW-1:0] aluresultM;
  logic [DPW-1:0] Rd2M;
  logic           memwriteM;
  logic [DPW-1:0] rd;

  logic           data_en;
  logic [DPW-1:0] input_data;
  logic [DPW-1:0] input_addr;
  logic [DPW-1:0] output_check;


  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTLS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  top top_inst (
      .clk         (clk),
      .arst_n      (arst_n),
      .data_en     (data_en),
      .input_data  (input_data),
      .input_addr  (input_addr),
      .output_check(output_check),
      .PCF         (PCF),
      .instrD      (instrD),
      .aluresultM  (aluresultM),
      .Rd2M        (Rd2M),
      .memwriteM   (memwriteM),
      .rd          (rd)
  );

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-METHODS
  //////////////////////////////////////////////////////////////////////////////////////////////////
  task start_tclk();
    fork
      forever begin
        clk = 1;
        #5;
        clk = 0;
        #5;
      end
    join_none
  endtask

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-PROCEDURALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  initial begin
    $display("\033[7;38m####################### TEST STARTED #######################\033[0m");
    $dumpfile("raw.vcd");
    $dumpvars;
  end

  final begin
    $display("\033[7;38m######################## TEST ENDED ########################\033[0m");
  end

  initial begin
    for (int i = 0; i <= PCF; i = i + 4) begin
      $display("PCF =%h,instr = %h, aluresultM=%h,Rd2M =%h, memwriteM=%h, rd =%h", PCF, instrD,
               aluresultM, Rd2M, memwriteM, rd);
    end
  end

  initial begin

    start_tclk();
    @(posedge clk) data_en <= 1;
    input_addr <= 32'h0;
    input_data <= 32'h5;
    repeat (1) @(posedge clk);
    data_en <= 0;
    repeat (1) @(posedge clk);
    data_en <= 1;
    input_addr <= 32'h4;
    input_data <= 32'h8;
    repeat (1) @(posedge clk);
    data_en <= 0;
    repeat (10) @(posedge clk);

    arst_n <= 0;
    repeat (3) @(posedge clk);
    arst_n <= 1;
    repeat (3) @(posedge clk);

    repeat (100) @(posedge clk);
    repeat (20) @(posedge clk);

    $finish;
  end

endmodule
